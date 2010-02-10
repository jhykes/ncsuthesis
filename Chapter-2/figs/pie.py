"""
Make a pie chart - see
http://matplotlib.sf.net/matplotlib.pylab.html#-pie for the docstring.

This example shows a basic pie chart with labels optional features,
like autolabeling the percentage, offsetting a slice with "explode"
and adding a shadow.

Requires matplotlib0-0.70 or later

"""
import matplotlib.pyplot as plt

# make a square figure and axes
plt.figure(1, figsize=(4,4))
plt.figure(1)
ax = plt.axes([0.1, 0.1, 0.8, 0.8])

labels = ['Vanilla', 'Chocolate', 'Strawberry', 'Raspberry']
fracs = [30, 40, 20, 10]

plt.pie(fracs, labels=labels, labeldistance=0.7)
#plt.title('Most Popular Ice Cream Flavor' )

plt.savefig("pie.pdf")

