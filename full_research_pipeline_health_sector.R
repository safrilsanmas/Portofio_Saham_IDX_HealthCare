
############################################################
# HEALTH SECTOR STOCK PORTFOLIO OPTIMIZATION
# USING PAM CLUSTERING AND MEAN–SEMIVARIANCE APPROACH
#
# Author  : Safril Ahmadi Sanmas
# Purpose : Research Portfolio (Undergraduate Thesis)
############################################################

############################
# 1. LIBRARIES
############################
library(readxl)
library(dplyr)
library(ggplot2)
library(gridExtra)
library(car)
library(cluster)
library(factoextra)
library(tidyverse)
library(quantmod)

############################
# 2. DATA INPUT & SELECTION
############################
# Place required datasets inside the /data directory

rasio_profit <- read_excel("data/rasio_profit.xlsx")
Data <- data.frame(rasio_profit[, 2:5])

############################
# 3. DESCRIPTIVE STATISTICS
############################
summary(Data)

sdp <- function(y) {
  nilai <- (y - mean(y))^2
  sqrt(sum(nilai) / (length(y) - 1))
}

sd_rasio <- as.data.frame(lapply(Data, sdp))

############################
# 4. MAHALANOBIS OUTLIER DETECTION
############################
mean_values <- colMeans(Data)
cov_matrix <- cov(Data)
D2 <- mahalanobis(Data, mean_values, cov_matrix)

alpha <- 0.05
k <- ncol(Data)
chi_square <- qchisq(1 - alpha, k)

############################
# 5. STANDARDIZATION (MAX-ABS)
############################
max_scaler <- function(x) {
  x / max(abs(x), na.rm = TRUE)
}

Data_scaled <- as.data.frame(lapply(Data, max_scaler))

############################
# 6. ASSUMPTION TESTS
############################
kmo_test <- function(x) {
  r <- cor(x)
  i <- solve(r)
  d <- diag(i)
  p2 <- (-i / sqrt(outer(d, d)))^2
  r2 <- r^2
  diag(r2) <- diag(p2) <- 0
  sum(r2) / (sum(r2) + sum(p2))
}

KMO_value <- kmo_test(Data_scaled)

Data_scaled$total <- rowSums(Data_scaled)
vif_model <- lm(total ~ ., data = Data_scaled)
vif(vif_model)

############################
# 7. PCA MANUAL
############################
x <- as.matrix(Data_scaled[, 1:4])
S <- cov(x)
eigen_values <- eigen(S)

pca <- princomp(covmat = S, cor = FALSE)
summary(pca)

############################
# 8. PAM CLUSTERING
############################
pam_result <- pam(x, k = 3)
fviz_cluster(pam_result, data = x)

############################
# 9. STOCK PRICE & RETURN
############################
symbols <- c("BMHS.JK","HALO.JK","HEAL.JK","MIKA.JK","MTMH.JK","OMED.JK",
             "PRAY.JK","PRDA.JK","RSGK.JK","SILO.JK","SRAJ.JK","KLBF.JK",
             "MERK.JK","PEVE.JK","SIDO.JK","SOHO.JK","TSPC.JK","^JKSE")

getSymbols(symbols, from = "2023-03-01", to = "2024-12-31")

close_prices <- do.call(cbind, lapply(symbols, function(sym) Cl(get(sym))))
returns <- diff(log(close_prices))[-1, ]

############################
# 10. MEAN–SEMIVARIANCE
############################
mean_return <- colMeans(returns, na.rm = TRUE)

semivariance <- apply(
  returns,
  2,
  function(x) mean(pmin(x - mean(x), 0)^2, na.rm = TRUE)
)

weights <- rep(1 / ncol(returns), ncol(returns))
portfolio_return <- sum(weights * mean_return)
portfolio_risk <- sum(weights^2 * semivariance)

############################
# 11. VALUE AT RISK & SHARPE
############################
portfolio_returns <- rowSums(returns * weights)
VaR_95 <- quantile(portfolio_returns, 0.05)

Sharpe <- SharpeRatio.annualized(portfolio_returns)

############################
# 12. OUTPUT
############################
list(
  Portfolio_Return = portfolio_return,
  Portfolio_Risk = portfolio_risk,
  VaR_95 = VaR_95,
  Sharpe_Ratio = Sharpe
)
