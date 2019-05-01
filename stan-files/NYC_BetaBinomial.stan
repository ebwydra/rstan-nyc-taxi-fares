// Big Tippers Model 1
// Beta(1.41,4.28) population prior

data {
  int<lower=0> K; // number of clusters (row number)
  int<lower=0> n[K]; // total number of trips (by row number)
  int<lower=0> y[K]; // number of heavy tippers (by row number)
}

parameters {
  real<lower=0,upper=1> theta[K];
}

model {
  theta ~ beta(1.41,4.28);
  y ~ binomial(n,theta);
}
