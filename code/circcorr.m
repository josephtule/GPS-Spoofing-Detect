function [R, lag] = circcorr(x, y, Ts);
%
% Circular correlation of two vectors, x and y, through FFT methods. 
% 
% Output is R(lag), where R is the cross correlation of x and y and 
%  Lag is in the same dimesnions as Ts.
%
% Prof. Jim Garrison, Purdue University, AAE575 Fall 2009
%
npts = size(x,1);
X = fft(x);
Y = fft(y);
FTXY = X.*conj(Y);
R = fftshift(ifft(FTXY))/npts;
lag = [-floor(npts/2):floor((npts-1)/2)]*Ts;

end