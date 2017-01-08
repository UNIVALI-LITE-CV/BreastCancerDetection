% SHOWDPIC  Show demo pictures of the MATCNN environment
%
% $Id: showdpic.m,v 1.5 2002/01/15 19:15:46 rcsaba Exp $

% show all pictures

addpath('Data/')
figure
load pic1, subplot(241), cnnshow(TESTPIC); xlabel('pic1 (88x88)')
load pic2, subplot(242), cnnshow(TESTPIC); xlabel('pic2 (88x88)')
load pic3, subplot(243), cnnshow(TESTPIC); xlabel('pic3 (88x88)')
load pic4, subplot(244), cnnshow(TESTPIC); xlabel('pic4 (88x88)')
load pic5, subplot(245), cnnshow(TESTPIC); xlabel('pic5 (88x88)')
load pic6, subplot(246), cnnshow(TESTPIC); xlabel('pic6 (256x256)')
load pic7, subplot(247), cnnshow(TESTPIC); xlabel('pic7 (88x88)')
load pic8, subplot(248), cnnshow(TESTPIC); xlabel('pic8 (256x256)')

figure
load pic9, subplot(241), cnnshow(TESTPIC); xlabel('pic9 (256x256)')
load pic10, subplot(242), cnnshow(TESTPIC); xlabel('pic10 (88x88)')
load pic11, subplot(243), cnnshow(TESTPIC); xlabel('pic11 (88x88)')
load pic12, subplot(244), cnnshow(TESTPIC); xlabel('pic12 (88x88)')
load pic13, subplot(245), cnnshow(TESTPIC); xlabel('pic13 (128x128)')
load pic14, subplot(246), cnnshow(TESTPIC); xlabel('pic14 (128x128)')
load pic15, subplot(247), cnnshow(TESTPIC); xlabel('pic15 (256x256)')
load pic16, subplot(248), cnnshow(TESTPIC); xlabel('pic16 (256x256)')