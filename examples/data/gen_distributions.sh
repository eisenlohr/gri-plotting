#!/usr/bin/env python3

import numpy as np

N = 400
n = 3
rng = np.random.default_rng()

nrm = np.array([rng.normal(scale=i+1,size=N)      for i in range(n)]).T
exp = np.array([rng.exponential(scale=i+1,size=N) for i in range(n)]).T

print("1 header")
print(' '.join([f"normal@{i+1}"      for i in range(n)]),
      ' '.join([f"exponential@{i+1}" for i in range(n)]),
     )
for r in range(N):
    print(' '.join(list(map(str,np.hstack((nrm[r],exp[r]))))))
