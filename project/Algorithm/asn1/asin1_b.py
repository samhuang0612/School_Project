"""
Lishan Huang
250777962
cs3340 assignment1
Feb 1
"""
import sys
def merge(input):
    if len(input)>1:
        mid = len(input)//2
        p = input[:mid]
        q = input[mid:]
        merge(p)
        merge(q)
        i=0
	j=0
	k=0
	while i < len(p) and j < len(q):
            if p[i] < q[j]:
                input[k]=p[i]
                i=i+1
            else:
                input[k]=q[j]
                j=j+1
            k=k+1
        while i < len(p):
            input[k]=p[i]
            i=i+1
            k=k+1

        while j < len(q):
            input[k]=q[j]
            j=j+1
            k=k+1
str=sys.argv[1]
numb=int(str)
c=list(range(1,numb+1))
c.reverse()
print(c[:20])
alist = c
merge(alist)
print(alist[:20])
