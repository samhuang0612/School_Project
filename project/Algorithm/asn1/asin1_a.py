"""
Lishan Huang
250777962
cs3340 assignment1
Feb 1
"""
import sys
str=sys.argv[1]
numb=int(str)
a=list(range(1,numb+1))
a.reverse()
print(a[:20])
for j in range(1,len(a)):
    key=a[j]
    i=j-1
    while i>=0 and a[i]>key:
        a[i+1]=a[i]
        i=i-1
        a[i+1]=key
print(a[:20])


