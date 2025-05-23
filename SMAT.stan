
data {
  int<lower=0> N; // number of studies
  int<lower=1> m; // number of methods
  vector[N] y; // study outcomes
  vector[N] sigma_hat; // study reported standard error
  vector[m] sig_m; // belief about method's m bias. (In draft kappa_m) 
  matrix[N,m] label; //dummy matrix encoding whether study used method m
}


parameters {
  real mu;
  real<lower=0> sig;
  vector[N] eps;
  
  vector[m] b;

}

model {
 vector[N] bias = label*b;
  y ~ normal(mu + eps, sigma_hat);
  eps ~ normal(bias,sig);
  mu~normal(0,3);
  sig~normal(0,2.5);
  for (i in 1:m){
    b[i]~normal(0,sig_m[i]);
  }
}



