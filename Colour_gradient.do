webuse set https://www.jankabatek.com/datasets/
webuse gradient_data, clear

if c(version) < 18 {
	n di as err "Sorry, you need Stata 18 for this code to run!"
	xxxxx
}	

********************************************************************************
** (1) Box-standard gradient chart using the twoway command: 					
twoway bar FEE_CHANGE id, colorvar(FEE_CHANGE) colorstart(red) colorend(lime) 	/// essential colour gradient options. 
			colorcuts(-75(1)75) 												/// finer gradient options. Try adding: colorrule(lin)
			clegend(off) 														/// getting rid of the colour legend (it's messy)
			barwidth(0.9) 														/// making the bars look nicer 
			horizontal ylabel(1(1)27,val labs(small)) ytitle("") 				/// twoway options
			xtitle("Change in student fees (%)") xlabel(-75(25)125) name(GRDNT1,replace)  

********************************************************************************
** Install packages for other graphing options (allowing for further customization)

cap ssc install schemepack
net install plottabs, from("https://raw.githubusercontent.com/jankabatek/plotsuite/master/ado/") replace
cap ssc install coefplot

********************************************************************************
** (2) Plotmeans:
plotmeans FEE_CHANGE, over(id) clear gr(bar) ci(off)  							/// plotmeans options
			colorvar(y_val1) colorstart(red) colorend(lime) 	   				/// essential colour gradient options (note the different variable in colorvar - this is because plotmeans stores the plotted data in a separate frame with standardized variable names) 
			colorcuts(-75(1)75) 												/// finer gradient options. Try adding: colorrule(lin)
			clegend(off) 														/// getting rid of the colour legend (it's messy)
			scheme(white_tableau)												/// nicer theme, thx to Asjad 
			barwidth(0.9) 														/// making the bars look nicer 
			horizontal ylabel(1(1)27,val labs(small)) ytitle("") 				/// twoway options
			xtitle("Change in student fees (%)") xlabel(-75(25)125) name(GRDNT2,replace)  

********************************************************************************
** (3) Coefplot (needs to be combined with a regression / matrix creation):
reg FEE_CHANGE ibn.id, nocons

coefplot, 	recast(bar) grid(between glpattern(solid) glcolor(gs15)) 			/// coefplot options (incl. nicer horizontal grid lines)
			colorvar(FEE_CHANGE) colorstart(red) colorend(lime) 	   			/// essential colour gradient options. 
			colorcuts(-75(1)75) 												/// finer gradient options. Try adding: colorrule(lin)
			clegend(off) 														/// getting rid of the colour legend (it's messy)
			scheme(white_tableau)												/// nicer theme, thx to Asjad 
			barwidth(0.9) 														/// making the bars look nicer 
			xtitle("Change in student fees (%)") xlabel(-75(25)125) name(GRDNT3,replace)  
