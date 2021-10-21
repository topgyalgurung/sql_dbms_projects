g => {
    // config variables
    loanname={'label':'Loan Name','value':g.object.extraProps.loanname};
    dealname={'label':'Deal Name','value':g.object.extraProps.dealname}; 
    zipcode={'label':'ZIP','value':g.object.extraProps.zipcode};

    avg_hrs_chg3 = {'label': '3yr Hrs Worked Chg', 'value': g.object.extraProps.avg_hrs_chg3};
    avg_empl_chg3={'label': '3yr Employment Chg', 'value': g.object.extraProps.avg_empl_chg3};
    avg_pay_chg3={'label':'3yr Income Chg','value':g.object.extraProps.avg_pay_chg3};
    
    return `
    <h4>
        <div>${zipcode.label}: ${zipcode.value}</div>
        <div>${avg_pay_chg3.label}: ${avg_pay_chg3.value}</div>   
        <div>${avg_hrs_chg3.label}: ${avg_hrs_chg3.value}</div>  
        <div>${avg_empl_chg3.label}: ${avg_empl_chg3.value}</div>       
    </h4>
    <table style="width:100%; color:white; display: inline;">
          <tr style="width:100%;">
            <th style="text-align: left;">Metric</th>
            <th style="text-align: right;">Value</th> 
          </tr>
          <tr style="width: 100%;">
          <td style="width: 100%; white-space:nowrap;">
              <small>${dealname.label}</small>
          </td>
          <td style="text-align:right;">
              <small>${dealname.value}</small>
          </td> 
       </tr>

          <tr style="width: 100%;">
            <td style="width: 100%; white-space:nowrap;">
                <small>${dealname.label}</small>
            </td>
            <td style="text-align:right;">
                <small>${dealname.value}</small>
            </td> 
         </tr>
            <tr style="width: 100%;">
              <td style="width: 100%; white-space:nowrap;">
                  <small>${loanname.label}</small>
              </td>
              <td style="text-align:right;">
                  <small>${loanname.value}</small>
              </td> 
            </tr>
    `
}


// 2 decimal
employratechange.value = employratechange.value ? employratechange.value.toFixed(2) : '';

    //tract = {'label': 'Tract', 'value': g.object.extraProps.tract};
    //income_percentile = {'label': 'Income Percentile', 'value': g.object.extraProps.IncomePercentile};
  
    // 2 decimal
    income_percentile.value = income_percentile.value ? income_percentile.value.toFixed(2) : '';
  
    // currency
    // annual_income.value = annual_income.value ? '$' + annual_income.value.replace(/\d(?=(\d{3})+\.)/g, '$&,') : '-';
    
    // percentages
    // pct_college_grad.value = pct_college_grad.value ? pct_college_grad.value + '%' : '-';
    
 
    g => {
        // config variables
        zip = {'label': 'ZIP', 'value': g.object.extraProps.zip};
        income =  {'label': 'Income Percentile', 'value': g.object.extraProps.Income_Percentile};
        six_fig = {'label': '>$100K Earners', 'value': g.object.extraProps.Pct_Six_Fig_Income};
        education =  {'label': 'College Grads', 'value': g.object.extraProps.PctCollegeGrad};
        genYTenure =  {'label': 'Gen Y Percentile', 'value': g.object.extraProps.Gen_Y_Tenure_Percentile};
        medianRooms =  {'label': 'Median Rooms', 'value': g.object.extraProps.HousingMedianRooms};
        houseSize =  {'label': 'Home Size Percentile', 'value': g.object.extraProps.HousingSizePercentile};
        
        
        // 3 decimal
        income.value = income.value.toFixed(1);
    
        // Percentages
        education.value = education.value ? education.value + '%' : '-';
        six_fig.value = six_fig.value ? six_fig.value + '%' : '-';
        
        return `
        <h4>
            <div>${zip.label}: ${zip.value}</div>
            <div>${income.label}: ${income.value}</div>
        </h4>
        <br>
        <table style="width:100%; color:white; display: inline;">
          <tr style="width:100%;">
            <th style="text-align: left;">Metric</th>
            <th style="text-align: right;">Value</th> 
          </tr>
          <tr style="width: 100%;">
            <td style="width: 100%; white-space:nowrap;">
                <small>${six_fig.label}</small>
            </td>
            <td style="text-align:right;">
                <small>${six_fig.value}</small>
            </td> 
          </tr>
          <tr style="width: 100%;">
            <td style="width: 100%; white-space:nowrap;">
                <small>${education.label}</small>
            </td>
            <td style="text-align:right;">
                <small>${education.value}</small>
            </td> 
          </tr>
          <tr style="width: 100%;">
            <td style="width: 100%; white-space:nowrap;">
                <small>${genYTenure.label}</small>
            </td>
            <td style="text-align:right;">
                <small>${genYTenure.value}</small>
            </td> 
          </tr>
          <tr style="width: 100%;">
            <td style="width: 100%; white-space:nowrap;">
                <small>${medianRooms.label}</small>
            </td>
            <td style="text-align:right;">
                <small>${medianRooms.value}</small>
            </td> 
          </tr>
                <tr style="width: 100%;">
            <td style="width: 100%; white-space:nowrap;">
                <small>${houseSize.label}</small>
            </td>
            <td style="text-align:right;">
                <small>${houseSize.value}</small>
            </td> 
          </tr>
        </table>
        `
    }

--------------------------------------------------------------

g => {
    // config variables
    tract = {'label': 'Tract', 'value': g.object.extraProps.tract};
    commut_dist = {'label': 'Commute Distance (miles)', 'value': g.object.extraProps.CommuteDistMile};
  
    // 2 decimal
    commut_dist.value = commut_dist.value ? commut_dist.value.toFixed(2) : '';
    
    return `
    <h4>
        <div>${tract.label}: ${tract.value}</div>
        <div>${commut_dist.label}: ${commut_dist.value}</div>        
    </h4>
    `
}

g => {
    // config variables
    tract = {'label': 'Tract', 'value': g.object.extraProps.tract};
    income = {'label': ' Income Percentile', 'value': g.object.extraProps.IncomePercentile};
  
    // 2 decimal
    income.value = income.value ? income.value.toFixed(2) : '';
  
    // currency
    // annual_income.value = annual_income.value ? '$' + annual_income.value.replace(/\d(?=(\d{3})+\.)/g, '$&,') : '-';
    
    // percentages
    // pct_college_grad.value = pct_college_grad.value ? pct_college_grad.value + '%' : '-';
    
    return `
    <h4>
        <div>${tract.label}: ${tract.value}</div>
        <div>${income.label}: ${income.value}</div>        
    </h4>
    `
}
--------------------------------------------------------------

g => {
    // config variables
    home_block_group = {'label': 'BG#', 'value': g.object.extraProps.home_block_group};
    zip = {'label': 'Zipcode', 'value': g.object.extraProps.zip};
    income_percentile = {'label': 'Income Percentile', 'value': g.object.extraProps.IncomePercentile};
    six_figs_percentile = {'label': '100k+ Inc. Percentile', 'value': g.object.extraProps.SixFigsPercentile};
  
    // 2 decimal
    income_percentile.value = income_percentile.value ? income_percentile.value.toFixed(2) : '';
    six_figs_percentile.value = six_figs_percentile.value ? six_figs_percentile.value.toFixed(2) : '';
  
    // currency
    // annual_income.value = annual_income.value ? '$' + annual_income.value.replace(/\d(?=(\d{3})+\.)/g, '$&,') : '-';
    
    // percentages
    // pct_college_grad.value = pct_college_grad.value ? pct_college_grad.value + '%' : '-';
    
    return `
    <div style="background-color: #000;">
      <h4 style="text-align: left;">
        <div>${zip.label}: ${zip.value}</div>
        <div>${home_block_group.label}: ${home_block_group.value}</div>        
      </h4>
      <br>
      <table style="width:100%; color:white; display: inline-block;">
        
        <tr style="width:100%;">
          <th style="text-align: left;">Metric</th>
          <th style="text-align: right;">Value</th> 
        </tr>

        <tr style="width: 100%;">
          <td style="width: 100%; white-space:nowrap;">
            <small>${income_percentile.label}</small>
          </td>
          <td style="text-align:right;">
            <small>${income_percentile.value}</small>
          </td> 
        </tr>

        <tr style="width: 100%;">
          <td style="width: 100%; white-space:nowrap;">
            <small>${six_figs_percentile.label}</small>
          </td>
          <td style="width: 100%; text-align:right;">
            <small>${six_figs_percentile.value}</small>
          </td> 
        </tr>
    </div>
    `;
};