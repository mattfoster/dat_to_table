`dat_to_table.rb` is a simple script for converting tabulated data into LaTeX tables.

Use it to turn:

	$ cat `test.dat`
	#Percentile	ANC	Nat. Neigh	Nearest Neigh.	Linear	Cubic	BSI	Kriging
	50.0000	0.0309	0.0274	0.0345	0.0276	0.0275	0.0268	0.0264
	90.0000	0.0872	0.0772	0.1038	0.0790	0.0785	0.0762	0.0748
	95.0000	0.1088	0.0961	0.1305	0.0990	0.0974	0.0951	0.0929
	99.0000	0.1546	0.1383	0.1861	0.1462	0.1413	0.1369	0.1319

Into:

	$ ruby dat_to_table.rb test.dat 'Absolute error percentiles. 96\% sparsity' 'table:prcs'
	No extensions available.
	\begin{table}[!t]
	\caption{Absolute error percentiles. 96\% sparsity}
	\label{table:prcs}
	\centering
	\begin{tabular}{|c|c|c|c|c|c|c|c|c|c|c|}
	\hline
	Percentile & ANC & Nat. Neigh & Nearest Neigh. & Linear & Cubic & BSI & Kriging
	\\
	\hline
	50 & 0.0309 & 0.0274 & 0.0345 & 0.0276 & 0.0275 & 0.0268 & 0.0264 \\
	\hline
	90 & 0.0872 & 0.0772 & 0.1038 & 0.0790 & 0.0785 & 0.0762 & 0.0748 \\
	\hline
	95 & 0.1088 & 0.0961 & 0.1305 & 0.0990 & 0.0974 & 0.0951 & 0.0929 \\
	\hline
	99 & 0.1546 & 0.1383 & 0.1861 & 0.1462 & 0.1413 & 0.1369 & 0.1319 \\
	\hline
	\end{tabular}
	\end{table}

The above data in included, to allow you to test the script.

This was written for a specific purpose (my PhD thesis), so prints the first
column in a short form. You can easily modify it by changing 
`short_first = true` to `short_first = false`. 

`dat_to_table.rb` was written by [Matt Foster](http://hackerific.net) and is BSD licensed. Do as you will with it!