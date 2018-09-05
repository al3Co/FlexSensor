# time testings
import time

tic = time.time()
actual = 0;

while True:
    elapsed = int(time.time() - tic)
    if actual != elapsed:
        actual = elapsed
        print('\rSec: {}'.format(elapsed), sep='\n', end='', flush=True)
