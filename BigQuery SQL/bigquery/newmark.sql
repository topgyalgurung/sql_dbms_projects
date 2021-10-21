/*
    create time series starting 2008 using yyyymm
    zip for each zip codes within MSA New York
    yyyymm combination includes naics code
    aggregate yyyymm to the level of zip

    end product:
        time series of yyyymm(time)
        zip
        avg annual income
*/
--
  -- income data from ADP , of diff markets and submarkets
  -- all industries in one zip should be combined
  -- employees summed
  -- each yyyymm, zip combination should be unique
  -- sum the employees and sum all the income
  -- Sum(income)/sum(employees) = average income