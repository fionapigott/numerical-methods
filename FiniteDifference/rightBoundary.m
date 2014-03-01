function phantom = rightBoundary(n, alpha, beta, gamma, deltaX, uCur)


phantom = 2*deltaX*((gamma-alpha*uCur(n))/beta)+uCur(n-1);    


end