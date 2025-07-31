#!/usr/bin/env python3
fn = "chr2.pvar"
out_fn = "allchr_SURV_CPH_p2in.txt"
count = 0
id_pairs = []
start, end =  None,None
with open(fn, 'r') as f:
  for l in iter(f.readline, ''):
    if l[0] == '#':
      continue
    data = l.strip().split('	')
    vid = data[2]
    count += 1
    if start is None:
      start = vid

    if count >= 10000:
      end = vid
      id_pairs.append( (start, end) )
      start = None
      end = None
      count = 0

if count > 0:
  end = vid
  id_pairs.append( (start, end) )

with open(out_fn, 'w') as f:
  for start,end in id_pairs:
    f.write( '\t'.join([start,end]) + '\n' )
