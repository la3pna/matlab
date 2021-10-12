The code in the VNA folder is not mine, I have modified some of it to fit my usage, but all of it is based on code from:
% Writer : C. van Niekerk
% Version : 3.50
% Date : 07/06/1995

As for the equations, they do follow almost directly from:
% [1] G.F. Engen, C.A. Hoer, "Thru-Reflect-Line: An Improved Technique for
% Calibrating the Dual Six-Port Automatic Network Analyser,"
% IEEE Trans. MTT, Vol. 27,No. 12, December 1979, pp. 987-998

Use TRL stone if you don't understand the difference between the routines, this one works on touchstone files directly.

For TRL stone, check that your line length is propper, if it is to short, you will get invalid data with no way to determine that. Please look at the resolved issues to see if anyone else has the same problem.

When opening a issue, provide the following:
-  In the issue text:
1. What you have tried (what script, options etc)
2. Line electrical length
3. Link to github repo, see below
4. What the problem seems to be, and how you have tried to solve it.
5. If the data are real or simulated. 

-  In a github repo:
1. All of your S-parameters
2. File and Plot of resulting S-parameters, frequency list and propagation constant. This is all the function returns!
3. plot of amplitude (dB) + phase (in same plot) of all your s-parameters that you feed into the algorithm.


**Fault finding a TRL calibration can take a lot of hours, currently I have no time to do that, and if you are not able to fully understand all of the articles quoted earlier, then you should not attempt using this code, specialy not the multiline code. I'm not able to answer any questions regarding this code, Its been years since I did anything with it, and would require lots of time to get into the subtile details of the code. Its important to know that its not my code to begin with, its written in 1995 (I was 8yrs) by C. V. N.**
