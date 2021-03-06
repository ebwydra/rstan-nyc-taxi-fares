// Big Tippers Model 2
// Beta population prior with unknown parameters
// Based on hierarchical rat tumor model from Gelman et al. (2013)
// and HW3 solutions by Rob Trangucci

data {
  int<lower=0> K; // number of clusters (row number)
  int<lower=0> n[K]; // total number of trips (by row number)
  int<lower=0> y[K]; // number of heavy tippers (by row number)
}

parameters {
  real<lower=0,upper=1> theta[K];
  real log_alpha_plus_beta;
  real log_alpha_div_beta;
  }

transformed parameters {
  real alpha = exp(log_alpha_plus_beta) / (exp(-log_alpha_div_beta) + 1);
  real beta = exp(log_alpha_plus_beta) / (exp(log_alpha_div_beta) + 1);
  }

model {
  target += log(alpha) + log(beta); // jacobian
  target += log(alpha+beta)*(-2.5); // prior for alpha/beta
  target += beta_lpdf(theta | alpha, beta); // prior for group-level parameters
  target += binomial_lpmf(y | n, theta);// likelihood
}
