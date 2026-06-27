# Lab 05 — Investigate a Production Outage (Lesson 5)

## Goal
Find the start/end of a 500-error spike, the affected endpoint, the request
count, and the correlated application error — using only the command line.


## How to Learn From This Lab

Use the **predict → run → explain** loop:

1. **Predict:** write what you think the command will do.
2. **Run:** execute exactly one step.
3. **Explain:** write what the output means in plain language.
4. **Verify:** use a second command or the filesystem state to prove the result.

## Beginner Checkpoints

- Before using `awk`, label the fields in one sample log line.
- Build the investigation from count → window → endpoint → cause.
- Challenge: write the incident timeline without using the solution file, then compare.

## Setup — generate a realistic incident

Paste this to create `access.log` and `app.log` with a planted outage:

```bash
mkdir -p ~/swexp-lab/l05 && cd ~/swexp-lab/l05

awk 'BEGIN{
  srand(7);
  paths["/health"]=1; paths["/api/products"]=1; paths["/api/cart"]=1; paths["/api/checkout"]=1;
  split("GET POST", m, " ");
  for(min=0; min<60; min++){
    for(r=0; r<60; r++){
      h=14; mm=sprintf("%02d", min); ss=sprintf("%02d", r);
      ip=sprintf("10.0.%d.%d", int(rand()*4), int(rand()*254)+1);
      n=int(rand()*4)+1; cnt=0; path="/health";
      for(p in paths){ cnt++; if(cnt==n) path=p; }
      status=200;
      # plant a /api/checkout 500 spike from 14:00 to 14:25
      if(path=="/api/checkout" && min>=0 && min<=25 && rand()<0.7) status=500;
      printf "%s - - [01/Jun/2025:%02d:%s:%s +0000] \"%s %s HTTP/1.1\" %d 512\n", ip, h, mm, ss, m[int(rand()*2)+1], path, status;
    }
  }
}' > access.log

{
  echo "2025-06-01 13:59:10 INFO  app started, pool=10"
  echo "2025-06-01 14:00:05 ERROR PaymentGateway timeout: connection pool exhausted (max=10)"
  echo "2025-06-01 14:12:44 ERROR PaymentGateway timeout: connection pool exhausted (max=10)"
  echo "2025-06-01 14:25:31 INFO  pool size increased to 50; recovering"
  echo "2025-06-01 14:26:00 INFO  error rate back to baseline"
} > app.log

wc -l access.log app.log
```

## Tasks

1. **Status breakdown** (the top-N idiom):
   ```bash
   awk '{print $9}' access.log | sort | uniq -c | sort -rn
   ```
2. **Bound the incident** — first and last 500:
   ```bash
   grep ' 500 ' access.log | head -1
   grep ' 500 ' access.log | tail -1
   ```
3. **Affected count and endpoint:**
   ```bash
   grep ' 500 ' access.log | awk '{print $7}' | sort | uniq -c | sort -rn
   ```
4. **Correlate the cause** in the app log:
   ```bash
   grep -i error app.log
   ```

## Deliverable
Write `incident-timeline.md`: the spike window, affected count, offending
endpoint, and the root-cause line from `app.log`. Compare your answer to
[`../solutions/lab-05-solution.md`](../solutions/lab-05-solution.md).
