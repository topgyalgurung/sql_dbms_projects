g => {
    // config variables
    zip = {'label': 'ZIP', 'value': g.object.extraProps.zip};
    pct_college_grad = {'label': 'Col. Grad (%)', 'value': g.object.extraProps.PctCollegeGrad};
    //pct_six_fig_income = {'label': '>$100K Earners (%)', 'value': g.object.extraProps.Pct_Six_Fig_Income};
    income = {'label': 'Income Percentile', 'value': g.object.extraProps.Income_Percentile};
    HousingMedianRooms = {'label': 'Median Rooms', 'value': g.object.extraProps.HousingMedianRooms};
    // gen_x_tenure = {'label': 'GenX Percentile', 'value': g.object.extraProps.Gen_X_Tenure_Percentile};
    // gen_y_tenure = {'label': 'GenY Percentile', 'value': g.object.extraProps.Gen_Y_Tenure_Percentile};

    // 2 decimal
    
    // currency
    // annual_income.value = annual_income.value ? '$' + annual_income.value.replace(/\d(?=(\d{3})+\.)/g, '$&,') : '-';
    
    // percentages
    pct_college_grad.value = pct_college_grad.value ? pct_college_grad.value + '%' : '-';
    // pct_six_fig_income.value = pct_six_fig_income.value ? pct_six_fig_income.value + '%' : '-';
    
    return `
    <h4>
        <div>${zip.label}: ${zip.value}</div>
        <div>${pct_college_grad.label}: ${pct_college_grad.value}</div>        
    </h4>
    <br>
    <table style="width:100%; color:white; display: inline;">
      <tr style="width:100%;">
        <th style="text-align: left;">Metric</th>
        <th style="text-align: right;">Value</th> 
      </tr>
      <tr style="width: 100%;">
        <td style="width: 100%; white-space:nowrap;">
            <small>${income.label}</small>
        </td>
        <td style="text-align:right;">
            <small>${income.value}</small>
        </td> 
      </tr>      
      <tr>
        <td style="width: 100%; white-space:nowrap;">
            <small>${HousingMedianRooms.label}</small>
        </td>
        <td style="text-align:right;">
            <small>${HousingMedianRooms.value}</small>
        </td>
      </tr>
    </table>
    `
}

g => {
  // config variables
  home_block_group = {'label': 'Block Group', 'value': g.object.extraProps.home_block_group};
  income_percentile = {'label': 'Income Percentile', 'value': g.object.extraProps.IncomePercentile};

  // 2 decimal
  income_percentile.value = income_percentile.value ? income_percentile.value.toFixed(2) : '';

  // currency
  // annual_income.value = annual_income.value ? '$' + annual_income.value.replace(/\d(?=(\d{3})+\.)/g, '$&,') : '-';
  
  // percentages
  // pct_college_grad.value = pct_college_grad.value ? pct_college_grad.value + '%' : '-';
  
  return `
  <h4>
      <div>${home_block_group.label}: ${home_block_group.value}</div>
      <div>${income_percentile.label}: ${income_percentile.value}</div>        
  </h4>
  `
}

g => {
  // config variables
  zip = {'label': 'ZIP', 'value': g.object.extraProps.zip};
  income =  {'label': 'Income Percentile', 'value': g.object.extraProps.Income_Percentile};

  income.value =  income.value ? income.value.toFixed(2) : '';
  
  return `
  <h4>
      <div>${zip.label}: ${zip.value}</div>
      <div>${income.label}:${income.value}</div>
  </h4>
  `
}