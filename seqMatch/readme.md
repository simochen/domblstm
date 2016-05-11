###Pre-processing
1. load sequence file

		[obj, test] = load_seq(seqfile, domfile, type, isSave)
		
		type  = 'multi'/'single'
		obj = {seq_name, dom_name, seq, dom, len, range, rangei}[seqNum]
		test = {overlap, coverage, dom_poi}[domNum]
		
2. load feature file

		vec = load_feat(dir, r, obj, isSave)
		[yi = assign_label(len, range, r)]
		
		vec = {X, y, yi, len, range, rangei}[seqNum]
		
3. divide into group

		vec_group = divGroup(vec, group, isSave, basename)
		
		vec_group : 1*5 cell
					for each cell,
					{X, y, yi, len, range, rangei}
					
###Post-processing
######Post-process and Get prediction

	pred = postproc(raw_y, sub_vec, opt)
	[y = winSmooth(x, win)]
	
	sub_vec = {X, y, yi, len, range, rangei}
	opt = {win, cutoff, minBlen, skip, inComb, termComb, isShow, pauseTime[-1]}
	pred = {y, label, range}
	
######Plot and visualize prediction [embed in `postproc`]
		
	post_plot(pred, sub_vec, opt)
	
	pred = {y, range}
	sub_vec = {len, y, yi}
	opt = {cutoff, pauseTime[-1]}
	
###Evaluate
1.	evaluate model output
	
		eval = evaluate(pred, def)
		
		def = {label, range}
		def need to be pre-defined
		eg. for i = 1: numel(vec{2})
				def(i).label = vec{2}(i).yi
				def(i).range = vec{2}(i).rangei
			end
		eval = {m, t, ndo,
				dom{tp, fp, fn},
				bdr{tp, fp, fn},
				res{tp, fp, fn, tn}}
		
	**sub function**
		
		1. [common, olp] = overlap(range1, range2)
			range: 1*2 double or []
			if range = [], return [0, 0]
			
		2. linker = getLinker(range)
			linker = m*2 double 
			m can be 0, that is, linker = []
			
		3. olp = linker_overlap(linker, range)
			linker = m*2 double, m can be 0
			range  = n*2 double, n > 0
			olp = 1*n double
			
		4. domM = domMeasure(range_pred, range_def)
			range = n*2 double, n > 0
			domM = {tp, fp, fn, ndo}
			
		5. bdrM = boundaryMeasure(range_pred, range_def)
			range = n*2 double, n > 0
			bdrM = {tp, fp, fn}
			
		6. resM = residueMeasure(label_pred, label_def)
			resM = {tp, fp, fn, tn}
		
2. calculate evaluate criterion (precision, recall, f1 [,mcc])

		obj = eval_calc(obj)
		
		obj: [input]{tp, fp, fn} -> [output]{precision, recall, f1}
			 [input]{tp, fp, fn, tn} -> [output]{precision, recall, f1, acc, mcc}
			 
3. print evaluation
		
		eval_print(eval)