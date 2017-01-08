
%****************************** AVERAGE *****************************
%Function:	Smoothing with binary output.
%TemLibName:	Smoothing
%CNNModel:	Single-layer, CT-CNN
%Given:		Static gray-scale image P
%Setting:	Input:-, IniState:P, Boundary:Fixed(0)
%Output:	Binary image where black (white) pixels correspond to the locations in P where the average of pixel intensities over the r=1 feedback convolution window is above (under) a given threshold.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%NEIGHBORHOOD: 1
AVERAGE_A = [
0	1	0
1	2	1
0	1	0];

%****************************** AVERTRS1 *****************************
%Function:	Smoothing with binary output.
%TemLibName:	Smoothing
%CNNModel:	Single-layer, CT-CNN
%Given:		Static gray-scale image P
%Setting:	Input:-, IniState:P, Boundary:Fixed(0)
%Output:	Binary image where black (white) pixels correspond to the locations in P where the average of pixel intensities over the r=1 feedback convolution window is above (under) a given threshold.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%NEIGHBORHOOD: 1
AVERTRS1_A = [
	     0  1.2   0
	    1.2 1.8  1.2
	     0  1.2   0];

AVERTRS1_B = [
 0 0 0
 0 0 0
 0 0 0];

AVERTRS1_I = 0;
%****************************** AVERTRS2 *****************************
%Function:	Smoothing with binary output.
%TemLibName:	Smoothing
%CNNModel:	Single-layer, CT-CNN
%Given:		Static gray-scale image P
%Setting:	Input:-, IniState:P, Boundary:Fixed(0)
%Output:	Binary image where black (white) pixels correspond to the locations in P where the average of pixel intensities over the r=1 feedback convolution window is above (under) a given threshold.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%NEIGHBORHOOD: 1
AVERTRS2_A = [
	     0  0.9   0
	    0.9 1.8  0.9
	     0  0.9   0];

AVERTRS2_B = [
 0 0 0
 0 0 0
 0 0 0];

AVERTRS2_I = 0;
%****************************** AVERTRSH *****************************
%Function:	Smoothing with binary output.
%TemLibName:	Smoothing
%CNNModel:	Single-layer, CT-CNN
%Given:		Static gray-scale image P
%Setting:	Input:-, IniState:P, Boundary:Fixed(0)
%Output:	Binary image where black (white) pixels correspond to the locations in P where the average of pixel intensities over the r=1 feedback convolution window is above (under) a given threshold.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%NEIGHBORHOOD: 1
AVERTRSH_A = [
	    0  1  0
	    1  2  1
	    0  1  0];

AVERTRSH_I = 0;
%****************************** CCDMASKL *****************************
%Function:	Masked (right-to-left) connected component detection.
%TemLibName:	MaskedCCD
%CNNModel:	Single-layer, CT-CNN
%Given:		Static binary images P1 (mask) and P2
%Setting:	Input:P1, IniState:P2, Boundary:Fixed(0)
%Output:	Binary image that is the result of CCD type shifting P2 from right to left. Shifting is controlled by the mask P1.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%neighborhood: 1
CCDMASKL_A = [
 0 0 0
1 2 -1
0 0 0];

CCDMASKL_B = [
0  0 0
0 -3 0
0  0 0];

CCDMASKL_I = -3;
%****************************** CCDMASKR *****************************
%Function:	Masked (left-to-right) connected component detection.
%TemLibName:	MaskedCCD
%CNNModel:	Single-layer, CT-CNN
%Given:		Static binary images P1 (mask) and P2
%Setting:	Input:P1, IniState:P2, Boundary:Fixed(0)
%Output:	Binary image that is the result of CCD type shifting P2 from left to right. Shifting is controlled by the mask P1.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%neighborhood: 1
CCDMASKR_A = [
0 0 0
-1 2 1
0 0 0];

CCDMASKR_B = [
0  0 0
0 -3 0
0  0 0];

CCDMASKR_I = -3;
%****************************** CCD_DIAG *****************************
%Function:	Diagonal connected component detection.
%TemLibName:	DiagonalCCD
%CNNModel:	Single-layer, CT-CNN
%Given:		Static binary image P
%Setting:	Input:-, IniState:P, Boundary:Fixed(0)
%Output:	Binary image that shows the number of diagonally connected components in P.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%neighborhood: 1
CCD_DIAG_A = [
1  0  0
0  2  0
0  0 -1];


%****************************** CCD_HOR *****************************
%Function:	Horizontal connected component detection.
%TemLibName:	HorizontalCCD
%CNNModel:	Single-layer, CT-CNN
%Given:		Static binary image P
%Setting:	Input:-, IniState:P, Boundary:Fixed(0)
%Output:	Binary image that shows the number of horizontally connected components in P.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%neighborhood: 1
CCD_HOR_A = [
 0 0 0
1 2 -1
0 0 0];


%****************************** CCD_VERT *****************************
%Function:	Vertical connected component detection.
%TemLibName:	VerticalCCD
%CNNModel:	Single-layer, CT-CNN
%Given:		Static binary image P
%Setting:	Input:-, IniState:P, Boundary:Fixed(0)
%Output:	Binary image that shows the number of vertically connected components in P.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Neighborhood: 1
CCD_VERT_A = [
0  1  0
0  2  0
0 -1  0];


%****************************** CENTER1 *****************************
%Function:	Center point detection.
%TemLibName:	CenterPointDetection (Algorithm!)
%CNNModel:	Single-layer, DT-CNN
%Given:		Static binary image P
%Setting:	Input:-, IniState:P, Boundary:Fixed(0)
%Output:	Binary image where a black pixel indicates the approximated center point of the object in P.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%neighborhood: 1
CENTER1_A = [
0.0000   0.0000   0.0000
0.0000   1.0000   0.0000
0.0000   0.0000   0.0000];

CENTER1_B = [
1.0000   0.0000   0.0000   
1.0000   4.0000   -1.0000   
1.0000   0.0000   0.0000   ];

CENTER1_I = -1.0000;
%****************************** CENTER2 *****************************
%Function:	Center point detection.
%TemLibName:	CenterPointDetection (Algorithm!)
%CNNModel:	Single-layer, DT-CNN
%Given:		Static binary image P
%Setting:	Input:-, IniState:P, Boundary:Fixed(0)
%Output:	Binary image where a black pixel indicates the approximated center point of the object in P.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%neighborhood: 1
CENTER2_A = [
0.0000   0.0000   0.0000
0.0000   1.0000   0.0000
0.0000   0.0000   0.0000];

CENTER2_B = [
1.0000   1.0000   1.0000   
1.0000   6.0000   0.0000   
1.0000   0.0000   -1.0000   ];

CENTER2_I = -1.0000;
%****************************** CENTER3 *****************************
%Function:	Center point detection.
%TemLibName:	CenterPointDetection (Algorithm!)
%CNNModel:	Single-layer, DT-CNN
%Given:		Static binary image P
%Setting:	Input:-, IniState:P, Boundary:Fixed(0)
%Output:	Binary image where a black pixel indicates the approximated center point of the object in P.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%neighborhood: 1
CENTER3_A = [
0.0000   0.0000   0.0000
0.0000   1.0000   0.0000
0.0000   0.0000   0.0000];

CENTER3_B = [
1.0000   1.0000   1.0000   
0.0000   4.0000   0.0000   
0.0000  -1.0000   0.0000   ];

CENTER3_I = -1.0000;
%****************************** CENTER4 *****************************
%Function:	Center point detection.
%TemLibName:	CenterPointDetection (Algorithm!)
%CNNModel:	Single-layer, DT-CNN
%Given:		Static binary image P
%Setting:	Input:-, IniState:P, Boundary:Fixed(0)
%Output:	Binary image where a black pixel indicates the approximated center point of the object in P.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%neighborhood: 1
CENTER4_A = [
0.0000   0.0000   0.0000
0.0000   1.0000   0.0000
0.0000   0.0000   0.0000];

CENTER4_B = [
 1.0000   1.0000   1.0000   
 0.0000   6.0000   1.0000   
-1.0000   0.0000   1.0000   ];

CENTER4_I = -1.0000;
%****************************** CENTER5 *****************************
%Function:	Center point detection.
%TemLibName:	CenterPointDetection (Algorithm!)
%CNNModel:	Single-layer, DT-CNN
%Given:		Static binary image P
%Setting:	Input:-, IniState:P, Boundary:Fixed(0)
%Output:	Binary image where a black pixel indicates the approximated center point of the object in P.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%neighborhood: 1
CENTER5_A = [
0.0000   0.0000   0.0000
0.0000   1.0000   0.0000
0.0000   0.0000   0.0000];

CENTER5_B = [
 0.0000   0.0000   1.0000   
-1.0000   4.0000   1.0000   
 0.0000   0.0000   1.0000   ];

CENTER5_I = -1.0000;
%****************************** CENTER6 *****************************
%Function:	Center point detection.
%TemLibName:	CenterPointDetection (Algorithm!)
%CNNModel:	Single-layer, DT-CNN
%Given:		Static binary image P
%Setting:	Input:-, IniState:P, Boundary:Fixed(0)
%Output:	Binary image where a black pixel indicates the approximated center point of the object in P.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%neighborhood: 1
CENTER6_A = [
0.0000   0.0000   0.0000
0.0000   1.0000   0.0000
0.0000   0.0000   0.0000];

CENTER6_B = [
-1.0000   0.0000   1.0000   
 0.0000   6.0000   1.0000   
 1.0000   1.0000   1.0000   ];

CENTER6_I = -1.0000;
%****************************** CENTER7 *****************************
%Function:	Center point detection.
%TemLibName:	CenterPointDetection (Algorithm!)
%CNNModel:	Single-layer, DT-CNN
%Given:		Static binary image P
%Setting:	Input:-, IniState:P, Boundary:Fixed(0)
%Output:	Binary image where a black pixel indicates the approximated center point of the object in P.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%neighborhood: 1
CENTER7_A = [
0.0000   0.0000   0.0000
0.0000   1.0000   0.0000
0.0000   0.0000   0.0000];

CENTER7_B = [
 0.0000  -1.0000   0.0000   
 0.0000   4.0000   0.0000   
 1.0000   1.0000   1.0000   ];

CENTER7_I = -1.0000;
%****************************** CENTER8 *****************************
%Function:	Center point detection.
%TemLibName:	CenterPointDetection (Algorithm!)
%CNNModel:	Single-layer, DT-CNN
%Given:		Static binary image P
%Setting:	Input:-, IniState:P, Boundary:Fixed(0)
%Output:	Binary image where a black pixel indicates the approximated center point of the object in P.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%neighborhood: 1
CENTER8_A = [
0.0000   0.0000   0.0000
0.0000   1.0000   0.0000
0.0000   0.0000   0.0000];

CENTER8_B = [
 1.0000   0.0000  -1.0000   
 1.0000   6.0000   0.0000   
 1.0000   1.0000   1.0000   ];

CENTER8_I = -1.0000;
%****************************** CLDILA *****************************
%Function:	Dilation (algo#).
%TemLibName:	- ?
%CNNModel:	Single-layer, CT-CNN
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%NEIGHBORHOOD: 1
CLDILA_A = [
0  0  0
0  2  0
0  0  0];

CLDILA_B = [
 0   0	  0
 1   1	  0
 1   1	  0];

CLDILA_I = 3.5;
%****************************** CLERO *****************************
%Function:	Erosion (algo#).
%TemLibName:	- ?
%CNNModel:	Single-layer, CT-CNN
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%NEIGHBORHOOD: 1
CLERO_A = [
0  0  0
0  2  0
0  0  0];

CLERO_B = [
 0   1	  1
 0   1	  1
 0   0	  0];

CLERO_I = -3.5;
%****************************** CNTR1 *****************************
%Function:	Center point detection.
%TemLibName:	CenterPointDetection (Algorithm!)
%CNNModel:	Single-layer, CT-CNN
%Given:		Static binary image P
%Setting:	Input:P, IniState:P, Boundary:Fixed(0)
%Output:	Binary image where a black pixel indicates the approximated center point of the object in P.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%neighborhood: 1
CNTR1_A = [
   1  0   0
   1  4  -1
   1  0   0];

CNTR1_I = -1;
%****************************** CNTR2 *****************************
%Function:	Center point detection.
%TemLibName:	CenterPointDetection (Algorithm!)
%CNNModel:	Single-layer, CT-CNN
%Given:		Static binary image P
%Setting:	Input:P, IniState:P, Boundary:Fixed(0)
%Output:	Binary image where a black pixel indicates the approximated center point of the object in P.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%neighborhood: 1
CNTR2_A = [
   1  1  1
   1  6  0
   1  0 -1];

CNTR2_I = -1;
%****************************** CNTR3 *****************************
%Function:	Center point detection.
%TemLibName:	CenterPointDetection (Algorithm!)
%CNNModel:	Single-layer, CT-CNN
%Given:		Static binary image P
%Setting:	Input:P, IniState:P, Boundary:Fixed(0)
%Output:	Binary image where a black pixel indicates the approximated center point of the object in P.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%neighborhood: 1
CNTR3_A = [
   1  1  1
   0  4  0
   0 -1  0];

CNTR3_I = -1;
%****************************** CNTR4 *****************************
%Function:	Center point detection.
%TemLibName:	CenterPointDetection (Algorithm!)
%CNNModel:	Single-layer, CT-CNN
%Given:		Static binary image P
%Setting:	Input:P, IniState:P, Boundary:Fixed(0)
%Output:	Binary image where a black pixel indicates the approximated center point of the object in P.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%neighborhood: 1
CNTR4_A = [
   1  1  1
   0  6  1
  -1  0  1];

CNTR4_I = -1;
%****************************** CNTR5 *****************************
%Function:	Center point detection.
%TemLibName:	CenterPointDetection (Algorithm!)
%CNNModel:	Single-layer, CT-CNN
%Given:		Static binary image P
%Setting:	Input:P, IniState:P, Boundary:Fixed(0)
%Output:	Binary image where a black pixel indicates the approximated center point of the object in P.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%neighborhood: 1
CNTR5_A = [
   0  0  1
  -1  4  1
   0  0  1];

CNTR5_I = -1;
%****************************** CNTR6 *****************************
%Function:	Center point detection.
%TemLibName:	CenterPointDetection (Algorithm!)
%CNNModel:	Single-layer, CT-CNN
%Given:		Static binary image P
%Setting:	Input:P, IniState:P, Boundary:Fixed(0)
%Output:	Binary image where a black pixel indicates the approximated center point of the object in P.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%neighborhood: 1
CNTR6_A = [
  -1  0  1
   0  6  1
   1  1  1];

CNTR6_I = -1;
%****************************** CNTR7 *****************************
%Function:	Center point detection.
%TemLibName:	CenterPointDetection (Algorithm!)
%CNNModel:	Single-layer, CT-CNN
%Given:		Static binary image P
%Setting:	Input:P, IniState:P, Boundary:Fixed(0)
%Output:	Binary image where a black pixel indicates the approximated center point of the object in P.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%neighborhood: 1
CNTR7_A = [
   0 -1  0
   0  4  0
   1  1  1];

CNTR7_I = -1;
%****************************** CNTR8 *****************************
%Function:	Center point detection.
%TemLibName:	CenterPointDetection (Algorithm!)
%CNNModel:	Single-layer, CT-CNN
%Given:		Static binary image P
%Setting:	Input:P, IniState:P, Boundary:Fixed(0)
%Output:	Binary image where a black pixel indicates the approximated center point of the object in P.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%neighborhood: 1
CNTR8_A = [
   1	 0    -1
   1     6     0
   1	 1     1];

CNTR8_I = -1;
%****************************** CONCCONT *****************************
%Function:	Concentric contour detection.
%TemLibName:	ConcentricContourDetector
%CNNModel:	Single-layer, CT-CNN
%Given:		Static binary image P
%Setting:	Input:P, IniState:P, Boundary:Fixed(0)
%Output:	Binary image where a black pixel indicates the approximated center point of the object in P.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%neighborhood: 1
CONCCONT_A = [
	0  -1  0
       -1 3.5 -1
	0  -1  0];

CONCCONT_B = [
	0 0 0
	0 4 0
	0 0 0];

CONCCONT_I = -4;
%****************************** CONCEROS *****************************
%Function:	Erosion (algo#).
%TemLibName:	- ?
%CNNModel:	Single-layer, CT-CNN
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%NEIGHBORHOOD: 1
CONCEROS_A = [
0  0  0
0  2  0
0  0  0];

CONCEROS_B = [
1  1  1
1  2  1
1  1  1];

CONCEROS_I = -0.5;
%****************************** CONCHOLL *****************************
%Function:	Hollow (algo#).
%TemLibName:	- ?
%CNNModel:	Single-layer, CT-CNN
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%NEIGHBORHOOD: 1
CONCHOLL_A = [
	    0.5  0.5  0.5
	    0.5   2   0.5
	    0.5  0.5  0.5];

CONCHOLL_B = [
 0 0 0
 0 2 0
 0 0 0];

CONCHOLL_I = 3.5;
%****************************** CONCTRES *****************************
%Function:	Thresholding (algo#).
%TemLibName:	- ?
%CNNModel:	Single-layer, CT-CNN
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Neighborhood: 1
CONCTRES_A = [
 0   0	 0
 0   2	 0
 0   0	 0];

CONCTRES_I = 0.0;
%****************************** CONNECTI *****************************
%Function:	Deletes marked objects.
%TemLibName:	Connectivity
%CNNModel:	Single-layer, CT-CNN
%Given:		Static binary images P1 (mask) and P2 (marker)
%Setting:	Input:P1, IniState:P2, Boundary:Fixed(0)
%Output:	Binary image containing only the unmarked objects in P1.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%neighborhood: 1
CONNECTI_A = [
0   0.5   0
0.5   3   0.5
0   0.5   0];

CONNECTI_B = [
 0   -0.5   0   
-0.5   3   -0.5   
 0   -0.5   0   ];

CONNECTI_I = -4.5;
%****************************** CORNCH_1 *****************************
%Function:	Convex corner detection.
%TemLibName:	CornerDetector
%CNNModel:	Single-layer, CT-CNN
%Given:		Static binary image P
%Setting:	Input:P, IniState:Arbitrary(0), Boundary:Fixed(0)
%Output:	Binary image where black pixels represent the convex corners of objects in P.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%neighborhood: 1
CORNCH_1_A = [
0.0000	 0.0000   0.0000
0.0000	 1   0.0000
0.0000	 0.0000   0.0000];

CORNCH_1_B = [
-1.0000   -1.0000   -1.0000
-1.0000   3.900   -1.0000
-1.0000   -1.0000   -1.0000];

CORNCH_1_I = -5.0000;
%****************************** CORNCH_2 *****************************
%Function:	Convex corner detection.
%TemLibName:	CornerDetector
%CNNModel:	Single-layer, CT-CNN
%Given:		Static binary image P
%Setting:	Input:P, IniState:Arbitrary(0), Boundary:Fixed(0)
%Output:	Binary image where black pixels represent the convex corners of objects in P.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%neighborhood: 1
CORNCH_2_A = [
0.0000	 0.0000   0.0000
0.0000	 0.5000   0.0000
0.0000	 0.0000   0.0000];

CORNCH_2_B = [
-1.0000   -1.0000   -1.0000
-1.0000   3.60000   -1.0000
-1.0000   -1.0000   -1.0000];

CORNCH_2_I = -5.0000;
%****************************** CORNER *****************************
%Function:	Convex corner detection.
%TemLibName:	CornerDetector
%CNNModel:	Single-layer, CT-CNN
%Given:		Static binary image P
%Setting:	Input:P, IniState:Arbitrary(0), Boundary:Fixed(0)
%Output:	Binary image where black pixels represent the convex corners of objects in P.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%neighborhood: 1
CORNER_A = [
0.0000   0.0000   0.0000
0.0000   1.0000   0.0000
0.0000   0.0000   0.0000];

CORNER_B = [
-1.0000   -1.0000   -1.0000   
-1.0000   4.0000   -1.0000   
-1.0000   -1.0000   -1.0000   ];

CORNER_I = -5.0000;
%****************************** DEADENDH *****************************
%Function:	Finds the endings of horizontal (1-pixel wide) objects.
%TemLibName:	DeadEndH
%CNNModel:	Single-layer, CT-CNN
%Given:		Static binary image P
%Setting:	Input:P, IniState:Arbitrary(0), Boundary:Fixed(0)
%Output:	Binary image of the endings of the horizontal (1-pixel wide) objects.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%NEIGHBORHOOD: 1
DEADENDH_A = [
0  0  0
0  3  0
0  0  0];

DEADENDH_B = [
-0.25  -0.25  -0.25
-0.25  0.5  -0.25
-0.25  -0.25  -0.25];

DEADENDH_I = -5.8;
%****************************** DEADENDV *****************************
%Function:	Finds the endings of vertical (1-pixel wide) objects.
%TemLibName:	DeadEndV
%CNNModel:	Single-layer, CT-CNN
%Given:		Static binary image P
%Setting:	Input:P, IniState:Arbitrary(0), Boundary:Fixed(0)
%Output:	Binary image of the endings of the vertical (1-pixel wide) objects.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%NEIGHBORHOOD: 1
DEADENDV_A = [
0  0  0
0  3  0
0  0  0];

DEADENDV_B = [
-0.25  -0.25  -0.25
-0.25  0.5  -0.25
-0.25  -0.25  -0.25];

DEADENDV_I = -5.8;
%****************************** DELDIAG1 *****************************
%Function:	Deletes one pixel wide diagonal lines.
%TemLibName:	DiagonalLineRemover
%CNNModel:	Single-layer, CT-CNN
%Given:		Static binary image P
%Setting:	Input:P, IniState:Arbitrary(0), Boundary:Fixed(-1)
%Output:	Binary image where black pixels have no black neighbors in diagonal directions in P.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%neighborhood: 1
DELDIAG1_A = [
0.0000   0.0000   0.0000
0.0000   1.0000   0.0000
0.0000   0.0000   0.0000];

DELDIAG1_B = [
-1.0000   0.0000   -1.0000   
0.0000   1.0000   0.0000   
-1.0000   0.0000   -1.0000   ];

DELDIAG1_I = -4.0000;
%****************************** DELVERT1 *****************************
%Function:	Deletes vertical lines.
%TemLibName:	VerticalLineRemover
%CNNModel:	Single-layer, CT-CNN
%Given:		Static binary image P
%Setting:	Input:P, IniState:Arbitrary(0), Boundary:Fixed(-1)
%Output:	Binary image representing P without vertical lines. Those parts of the objects that could be interpreted as vertical lines will also be deleted.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%neighborhood: 1
DELVERT1_A = [
0.0000   0.0000   0.0000
0.0000   1.0000   0.0000
0.0000   0.0000   0.0000];

DELVERT1_B = [
0.0000   -1.0000   0.0000   
0.0000   1.0000   0.0000   
0.0000   -1.0000   0.0000   ];

DELVERT1_I = -2.0000;
%****************************** DIAG *****************************
%Function:	Detects approximately diagonal lines.
%TemLibName:	ApproxDiagonalLineDetector
%CNNModel:	Single-layer, CT-CNN
%Given:		Static binary image P
%Setting:	Input:P, IniState:P, Boundary:Fixed(0)
%Output:	Binary image representing the locations of approximately diagonal lines in P.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Neighborhood: 2
DIAG_A = [
 0 0 0 0 0
 0 0 0 0 0
 0 0 2 0 0
 0 0 0 0 0
 0 0 0 0 0];

DIAG_I = -13;
DIAG_B = [
 -1  -1    -1   0.5    1
 -1  -1     1    1    0.5
 -1   1     5    1    -1 
 0.5   1    1   -1    -1
  1   0.5  -1   -1    -1];


%****************************** DIAG1LIU *****************************
%Function:	Diagonal line-detector.
%TemLibName:	DiagonalLineDetector
%CNNModel:	Single-layer, CT-CNN
%Given:		Static binary image P
%Setting:	Input:P, IniState:Arbitrary(0), Boundary:Fixed(0)
%Output:	Binary image representing the locations of diagonal lines in P.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%neighborhood: 1
DIAG1LIU_A = [
0.0000   0.0000   0.0000
0.0000   1.0000   0.0000
0.0000   0.0000   0.0000];

DIAG1LIU_B = [
-1.0000   0.0000   1.0000   
0.0000   1.0000   0.0000   
1.0000   0.0000   -1.0000   ];

DIAG1LIU_I = -4.0000;
%****************************** DIFFUS *****************************
%Function:	Filtering-reconstruction with heat-diffusion.
%TemLibName:	HeatDiffusion.
%CNNModel:	Single-layer, CT-CNN
%Given:		Static (noisy) gray-scale image P
%Setting:	Input:-, IniState:P, Boundary:Fixed(0)
%Output:	Grayscale image representing the result of the heat diffusion operation.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%NEIGHBORHOOD: 1
DIFFUS_A = [
    0.1  0.15  0.1
    0.15  0    0.15
    0.1  0.15  0.1];

DIFFUS_I = 0;
%****************************** DILATION *****************************
%Function:	Binary dilation.
%TemLibName:	- ?
%CNNModel:	Single-layer, CT-CNN
%Given:		Static binary image P
%Setting:	Input:P, IniState:Arbitrary(0), Boundary:Fixed(0)
%Output:	Binary image representing the result of the dilation operation.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%NEIGHBORHOOD: 1
DILATION_A = [
0  0  0
0  0  0
0  0  0];

DILATION_B = [
 0   0	  0
 1   1	  0
 0   1	  0];

DILATION_I = 2;
%****************************** EDGE *****************************
%Function:	Binary edge detection.
%TemLibName:	EdgeDetector
%CNNModel:	Single-layer, CT-CNN
%Given:		Static binary image P
%Setting:	Input:P, IniState:Arbitrary(0), Boundary:Zero-flux
%Output:	Binary image showing all edges of P in black.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%neighborhood: 1
EDGE_A = [
0.0000   0.0000   0.0000
0.0000   1.0000   0.0000
0.0000   0.0000   0.0000];

EDGE_B = [
-1.0000   -1.0000   -1.0000   
-1.0000    8.0000   -1.0000   
-1.0000   -1.0000   -1.0000   ];

EDGE_I = -1.0000;
%****************************** EDGEGRAY *****************************
%Function:	Gray-scale edge detection.
%TemLibName:	- ?
%CNNModel:	Single-layer, CT-CNN
%Given:		Static gray-scale image P
%Setting:	Input:P, IniState:Arbitrary(0), Boundary:Zero-flux
%Output:	Gray-scale image showing an edge map of P in black.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%NEIGHBORHOOD: 1
EDGEGRAY_A = [
0  0  0
0  2  0
0  0  0];

EDGEGRAY_I = -0.5;
EDGEGRAY_B = [
-1.0  -1.0  -1.0
-1.0   8.0  -1.0
-1.0  -1.0  -1.0];

%****************************** ERASMASK *****************************
%Function:	Masked erase.
%TemLibName:	MaskedObjectExtractor
%CNNModel:	Single-layer, CT-CNN
%Given:		Static binary image P1 (mask) and P2
%Setting:	Input:P1, IniState:P2, Boundary:Fixed(0)
%Output:	Binary image that is the result of erasing P2 from left to right. Erasure is stopped by the black walls on the mask (P1) image.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%neighborhood: 1
ERASMASK_A = [
 0  0  0
 1.5 3 0
 0  0  0];

ERASMASK_B = [
0  0 0
0  1.5 0
0  0 0];

ERASMASK_I = -1.5;
%****************************** EROSION *****************************
%Function:	Binary erosion.
%TemLibName:	- ?
%CNNModel:	Single-layer, CT-CNN
%Given:		Static binary image P
%Setting:	Input:P, IniState:Arbitrary(0), Boundary:Fixed(0)
%Output:	Binary image representing the result of the erosion operation.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%NEIGHBORHOOD: 1
EROSION_A = [
0  0  0
0  0  0
0  0  0];

EROSION_B = [
 0   1	  0
 0   1	  1
 0   0	  0];

EROSION_I = -2;
%****************************** FIGDEL *****************************
%Function:	Extracts isolated black pixels.
%TemLibName:	FigureRemover
%CNNModel:	Single-layer, CT-CNN
%Given:		Static binary image P
%Setting:	Input:P, IniState:Arbitrary(0), Boundary:Fixed(0)
%Output:	Binary image representing all isolated black pixels in P.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%neighborhood: 1
FIGDEL_A = [
0.0000   0.0000   0.0000
0.0000   1.0000   0.0000
0.0000   0.0000   0.0000];

FIGDEL_B = [
-1.0000   -1.0000   -1.0000   
-1.0000   1.0000   -1.0000   
-1.0000   -1.0000   -1.0000   ];

FIGDEL_I = -8.0000;
%****************************** FIGEXTR *****************************
%Function:	Deletes isolated black pixels.
%TemLibName:	FigureExtractor
%CNNModel:	Single-layer, CT-CNN
%Given:		Static binary image P
%Setting:	Input:P, IniState:Arbitrary(0), Boundary:Fixed(0)
%Output:	Binary image showing all connected components in P.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%neighborhood: 1
FIGEXTR_A = [
0.0000   0.0000   0.0000
0.0000   1.0000   0.0000
0.0000   0.0000   0.0000];

FIGEXTR_B = [
1.0000   1.0000   1.0000   
1.0000   8.0000   1.0000   
1.0000   1.0000   1.0000   ];

FIGEXTR_I = -1.0000;
%****************************** FIGREC *****************************
%Function:	Reconstructs marked figures.
%TemLibName:	FigureReconstructor
%CNNModel:	Single-layer, CT-CNN
%Given:		Two static binary images P1 (mask) and P2 (marker). P2 contains just a part of P1.
%Setting:	Input:P1, IniState:P2, Boundary:Fixed(0)
%Output:	Binary image representing those objects of P1 which are marked by P2.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Neighborhood: 1
FIGREC_A = [
0.5 0.5 0.5
0.5 4.0 0.5
0.5 0.5 0.5];

FIGREC_I = 3;
FIGREC_B = [
0 0 0
0 4 0
0 0 0];


%****************************** FILBLACK *****************************
%Function:	Drives the whole network into black.
%TemLibName:	BlackFiller
%CNNModel:	Single-layer, CT-CNN
%Given:		Static gray-scale image P
%Setting:	Input:-, IniState:P, Boundary:Fixed(0)
%Output:	Binary (black) image.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Neighborhood:	1
FILBLACK_A = [
 0 0 0
 0 2 0
 0 0 0];

FILBLACK_I = 4;
%****************************** FILWHITE *****************************
%Function:	Drives the whole network into white.
%TemLibName:	WhiteFiller
%CNNModel:	Single-layer, CT-CNN
%Given:		Static gray-scale image P
%Setting:	Input:-, IniState:P, Boundary:Fixed(0)
%Output:	Binary (white) image.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Neighborhood:	1
FILWHITE_A = [
 0 0 0
 0 2 0
 0 0 0];

FILWHITE_I = -4;
%****************************** FINDAREA *****************************
%Function:	Finds solid black framed areas.
%TemLibName:	FramedAreasFinder
%CNNModel:	Single-layer, CT-CNN
%Given:		Two static binary images P1 (mask) and P2 (marker).
%Setting:	Input:P1, IniState:P2, Boundary:Fixed(0)
%Output:	Binary image representing those objects of P1 which are marked by P2.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%NEIGHBORHOOD: 1
FINDAREA_A = [
   0  1  0
   1  5  1
   0  1  0];

FINDAREA_B = [
 0 0 0
 0 2 0
 0 0 0];

FINDAREA_I = -5.25;
%****************************** HLF3 *****************************
%Function:	3x3 image halftoning.
%TemLibName:	3x3Halftoning
%CNNModel:	Single-layer, CT-CNN
%Given:		Static gray-scale image P
%Setting:	Input:P, IniState:P, Boundary:Fixed(0)
%Output:	Binary image preserving the main features of P.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%neighborhood: 1
HLF3_A = [
  -0.07  -0.1  -0.07
  -0.1	  1.03 -0.1
  -0.07  -0.1  -0.07];

HLF3_I = 0.0000;
HLF3_B = [
  0.07	0.1  0.07
  0.1	0.32 0.1
  0.07	0.1  0.07];


%****************************** HLF5 *****************************
%Function:	5x5 image halftoning.
%TemLibName:	5x5Halftoning2
%CNNModel:	Single-layer, CT-CNN
%Given:		Static gray-scale image P
%Setting:	Input:P, IniState:P, Boundary:Fixed(0)
%Output:	Binary image preserving the main features of P.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%neighborhood: 2
HLF5_A = [
 -0.0245  -0.07  -0.099  -0.07	 -0.0245
 -0.07	  -0.324 -0.46	 -0.324  -0.07
 -0.099   -0.46   1.05	 -0.46	 -0.099
 -0.07	  -0.324 -0.46	 -0.324  -0.07
 -0.0245  -0.07  -0.099  -0.07	 -0.0245];

HLF5_I = 0;
HLF5_B = [
  0.0245   0.07   0.099   0.07	  0.0245
  0.07	   0.324  0.46	  0.324   0.07
  0.099    0.46   0.81	  0.46	  0.099
  0.07	   0.324  0.46	  0.324   0.07
  0.0245   0.07   0.099   0.07	  0.0245];


%****************************** HLF5KC *****************************
%Function:	5x5 image halftoning.
%TemLibName:	5x5Halftoning1
%CNNModel:	Single-layer, CT-CNN
%Given:		Static gray-scale image P
%Setting:	Input:P, IniState:P, Boundary:Fixed(0)
%Output:	Binary image preserving the main features of P.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%neighborhood: 2
HLF5KC_A = [
           -0.030 -0.086 -0.130 -0.086 -0.030
           -0.086 -0.359 -0.604 -0.359 -0.086
           -0.130 -0.604  1.050 -0.604 -0.130
           -0.086 -0.359 -0.604 -0.359 -0.086
           -0.030 -0.086 -0.130 -0.086 -0.030];

HLF5KC_I = 0.0;
HLF5KC_B = [
            0.000  0.000  0.068  0.000  0.000
            0.000  0.355  0.756  0.355  0.000
            0.068  0.756  2.122  0.756  0.068
            0.000  0.355  0.756  0.355  0.000
            0.000  0.000  0.068  0.000  0.000];


%****************************** HOLE *****************************
%Function:	Performs hole filling.
%TemLibName:	HoleFiller
%CNNModel:	Single-layer, CT-CNN
%Given:		Static binary image P
%Setting:	Input:P, IniState:1, Boundary:Fixed(0)
%Output:	Binary image representing P with holes filled.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Neighborhood: 1
HOLE_A = [
0  1  0
1  3  1
0  1  0];

HOLE_I = -1;
HOLE_B = [
0 0 0
0 4 0
0 0 0];


%****************************** HOLLOW *****************************
%Function:	Fills the concave locations of objects
%TemLibName:	ConcaveLocationFiller
%CNNModel:	Single-layer, CT-CNN
%Given:		Static binary image P
%Setting:	Input:P, IniState:P, Boundary:Fixed(0)
%Output:	Binary image in which the concave locations of objects are black.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%NEIGHBORHOOD: 1
HOLLOW_A = [
  0.5  0.5  0.5
  0.5   2   0.5
  0.5  0.5  0.5];

HOLLOW_B = [
 0 0 0
 0 2 0
 0 0 0];

HOLLOW_I = 3.25;
%****************************** HORLINE *****************************
%Function:	Horizontal line detector.
%TemLibName:	- ?
%CNNModel:	Single-layer, CT-CNN
%Given:		Static binary image P
%Setting:	Input:P, IniState:P, Boundary:Zero-flux
%Output:	Binary image, representing the horizontal lines in P.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%neighborhood: 1
HORLINE_A = [
0.0000	 0.0000   0.0000
1.0000	 2.0000   1.0000
0.0000	 0.0000   0.0000];

HORLINE_B = [
0   0	0
1   2	1
0   0	0];

HORLINE_I = -1;
%****************************** HORSKELL *****************************
%Function:	Horizontal skeleton from the left.
%TemLibName:	HorSkelL
%CNNModel:	Single-layer, CT-CNN
%Given:		Static binary image P
%Setting:	Input:P, IniState:Arbitrary(0), Boundary:Fixed(0)
%Output:	Binary image, peeling the black pixels from the left of the object.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%NEIGHBORHOOD: 1
HORSKELL_A = [
0  0  0
0  3  0
0  0  0];

HORSKELL_B = [
0.5  0  0.125
0.5  0.5  -0.5
0.5  0  0.125];

HORSKELL_I = -1;
%****************************** HORSKELR *****************************
%Function:	Horizontal skeleton from the right.
%TemLibName:	HorSkelR
%CNNModel:	Single-layer, CT-CNN
%Given:		Static binary image P
%Setting:	Input:P, IniState:Arbitrary(0), Boundary:Fixed(0)
%Output:	Binary image, peeling the black pixels from the right of the object.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%NEIGHBORHOOD: 1
HORSKELR_A = [
0  0  0
0  3  0
0  0  0];

HORSKELR_B = [
0.125  0  0.5
-0.5  0.5  -0.5
0.125  0  0.5];

HORSKELR_I = -1;
%****************************** INCREASE *****************************
%Function:	Increases the object by one pixel.
%TemLibName:	ObjectIncreasing
%CNNModel:	Single-layer, DT-CNN
%Given:		Static binary image P
%Setting:	Input:Arbitrary(0), IniState:P, Boundary:Zero-flux
%Output:	Binary image representing the objects of P increased by 1 pixel in all direction.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%neighborhood: 1
INCREASE_A = [
       .5  .5  .5
       .5  .5  .5
       .5  .5  .5];

INCREASE_I = 4;
%****************************** INTERP *****************************
%Function:	Interpolates a smooth surface through given points.
%TemLibName:	SurfaceInterpolation
%CNNModel:	Single-layer, CT-CNN
%Given:		A static grayscale image P1 and a static binary image P2
%Setting:	Input:-, IniState:P1, Boundary:Fixed(0), BiasMap:-, FixedStateMap:P2
%Output:	Grayscale image representing an interpolated surface that fits the given points and is as smooth as possible.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%NEIGHBORHOOD: 2
INTERP_A = [
	    0   0  -2  0  0
	    0  -4  16 -4  0
           -2  16 -39 16 -2
            0  -4  16 -4  0 
	    0   0  -2  0  0];


%****************************** INVHLF3 *****************************
%Function:	Inverts the halftoned image.
%TemLibName:	3x3InverseHalftoning
%CNNModel:	Single-layer, CT-CNN
%Given:		Static binary image P obtained by using 3x3Halftoning
%Setting:	Input:P, IniState:Arbitrary(0), Boundary:Zero-flux
%Output:	Gray-scale image representing P.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%neighborhood: 1
INVHLF3_A = [
  0  0	0
  0  0	0
  0  0	0];

INVHLF3_I = 0.0000;
INVHLF3_B = [
  0.07	0.1  0.07
  0.1	0.32 0.1
  0.07	0.1  0.07];


%****************************** INVHLF5 *****************************
%Function:	Inverts the halftoned image.
%TemLibName:	5x5InverseHalftoning
%CNNModel:	Single-layer, CT-CNN
%Given:		Static binary image P obtained by using 5x5Halftoning
%Setting:	Input:P, IniState:Arbitrary(0), Boundary:Zero-flux
%Output:	Gray-scale image representing P.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%neighborhood: 2
INVHLF5_A = [
    0 0 0 0 0
    0 0 0 0 0
    0 0 0 0 0
    0 0 0 0 0
    0 0 0 0 0];

INVHLF5_I = 0;
INVHLF5_B = [
 0.0049  0.014  0.0198  0.014   0.0049
 0.014   0.0648 0.092   0.0648  0.014
 0.0198  0.092  0.162   0.092   0.0198
 0.014   0.0648 0.092   0.0648  0.014
 0.0049  0.014  0.0198  0.014   0.0049];


%****************************** JUNCTION *****************************
%Function:	Extracts the junctions of a skeleton.
%TemLibName:	JunctionExtractor
%CNNModel:	Single-layer, CT-CNN
%Given:		Static binary image P
%Setting:	Input:P, IniState:Arbitrary(0), Boundary:Zero-flux
%Output:	Binary image showing the junctions of a skeleton.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%neighborhood: 1
JUNCTION_A = [
0.0000   0.0000   0.0000
0.0000   1.0000   0.0000
0.0000   0.0000   0.0000];

JUNCTION_B = [
1.0000   1.0000   1.0000   
1.0000   6.0000   1.0000   
1.0000   1.0000   1.0000   ];

JUNCTION_I = -3;
%****************************** LAPLACE *****************************
%Function:	Solves the Laplace PDE (Dx = 0).
%TemLibName:	LaplacePDESolver
%CNNModel:	Single-layer, CT-CNN
%Given:		Static gray-scale image P
%Setting:	Input:Arbitrary(0), IniState:P, Boundary:Zero-flux
%Output:	Gray-scale image - the solution of the Laplace equation.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%NEIGHBORHOOD: 1
LAPLACE_A = [
 0	1	0
 1	-3	1
 0	1	0];


%****************************** LCP *****************************
%Function:	Local concave place detector.
%TemLibName:	LocalConcavePlaceDetector
%CNNModel:	Single-layer, CT-CNN
%Given:		Static binary image P
%Setting:	Input:P, IniState:Arbitrary(0), Boundary:Fixed(0)
%Output:	Binary image showing the local concave places of P.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%neighborhood: 1
LCP_A = [
0.0000   0.0000   0.0000
0.0000   1.0000   0.0000
0.0000   0.0000   0.0000];

LCP_B = [
0.0000   0.0000   0.0000   
2.0000   2.0000   2.0000   
1.0000  -2.0000   1.0000   ];

LCP_I = -7.0000;
%****************************** LINCUT7H *****************************
%Function:	Deletes horizontal lines not longer than 7 pixels.
%TemLibName:	- ?
%CNNModel:	Single-layer, CT-CNN
%Given:		Static binary image P
%Setting:	Input:P, IniState:P, Boundary:Fixed(-1)
%Output:	Binary image where black pixels identify the horizontal lines with a length of 8 or more pixels in P.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%neighborhood: 2
LINCUT7H_A = [
 0   0	 0   0	  0
 0   0	 0   0	  0
 1   0.5 2   1   0.5
 0   0	 0   0	  0
 0   0	 0   0	  0];

LINCUT7H_I = -5.5;
LINCUT7H_B = [
 0   0	 0   0	  0
 0   0	 0   0	  0
 1   1	 1   1    1
 0   0	 0   0	  0
 0   0	 0   0	  0];


%****************************** LINCUT7V *****************************
%Function:	Deletes vertical lines not longer than 7 pixels.
%TemLibName:	LE7pixelVerticalLineRemover
%CNNModel:	Single-layer, CT-CNN
%Given:		Static binary image P
%Setting:	Input:P, IniState:P, Boundary:Fixed(-1)
%Output:	Binary image where black pixels identify the vertical lines with a length of 8 or more pixels in P.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%neighborhood: 2
LINCUT7V_A = [
 0   0	 1   0	  0
 0   0	 0.5 0	  0
 0   0	 2   0	  0
 0   0	 0.5 0	  0
 0   0	 1   0	  0];

LINCUT7V_I = -5.5;
LINCUT7V_B = [
 0   0	 1   0	  0
 0   0	 1   0	  0
 0   0	 1   0	  0
 0   0	 1   0	  0
 0   0	 1   0	  0];


%****************************** LINEXTR3 *****************************
%Function:	Lines-not-longer-than-3-pixels detector .
%TemLibName:	LE3pixelLineDetector
%CNNModel:	Single-layer, CT-CNN
%Given:		Static binary image P
%Setting:	Input:P, IniState:P, Boundary:Fixed(0)
%Output:	Binary image representing only lines not longer than 3 pixels in P.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  New version of the template
%  Length tuning in several directions: detection of lines with length
%  less or equal to 3 pixels
%neighborhood:  2
LINEXTR3_A = [
 0 0   0   0   0
 0 0.3 0.3 0.3 0
 0 0.3  3  0.3 0
 0 0.3 0.3 0.3 0
 0 0   0   0   0];

LINEXTR3_B = [
 -1  0 -1  0 -1
 0 -1 -1 -1  0
 -1 -1  4 -1 -1
 0 -1 -1 -1  0
 -1  0 -1  0 -1];

LINEXTR3_I = -2;
%****************************** LOGAND *****************************
%Function:	Logic AND (and Set Intersection).
%TemLibName:	LogicAND
%CNNModel:	Single-layer, CT-CNN
%Given:		Two static binary images P1 and P2
%Setting:	Input:P1, IniState:P2, Boundary:Fixed(0)
%Output:	Binary output of the logic operation AND between P1 and P2 (Set Intersection).
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Neighborhood:   1
LOGAND_A = [
0 0 0
0 2 0
0 0 0];

LOGAND_I = -1;
LOGAND_B = [
0 0 0
0 1 0
0 0 0];


%****************************** LOGDIF *****************************
%Function:	Logic Difference (alt: Relative Set Complement).
%TemLibName:	LogicDifference1
%CNNModel:	Single-layer, CT-CNN
%Given:		Two static binary images P1 and P2
%Setting:	Input:P1, IniState:P2, Boundary:Fixed(0)
%Output:	Binary image representing the set-theoretic, or logic complement of P2 relative to P1.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Neighborhood: 1
LOGDIF_A = [
0 0 0
0 2 0
0 0 0];

LOGDIF_I = -1;
LOGDIF_B = [
0  0  0
0 -1  0
0  0  0];


%****************************** LOGNOT *****************************
%Function:	Logic NOT (alt: Set Complementation)
%TemLibName:	LogicNOT
%CNNModel:	Single-layer, CT-CNN
%Given:		Static binary image P
%Setting:	Input:P, IniState:Arbitrary(0), Boundary:Fixed(0)
%Output:	Binary image where each black pixel in P becomes white, and vice versa.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Neighborhood: 1
LOGNOT_A = [
0 0 0
0 1 0
0 0 0];

LOGNOT_I = 0;
LOGNOT_B = [
0  0  0
0 -2  0
0  0  0];


%****************************** LOGOR *****************************
%Function:	Logic OR (alt: Set Union).
%TemLibName:	LogicOR
%CNNModel:	Single-layer, CT-CNN
%Given:		Two static binary images P1 and P2
%Setting:	Input:P1, IniState:P2, Boundary:Fixed(0)
%Output:	Binary output of the logic operation OR between P1 and P2 (Set Union).
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Neighborhood:	1
LOGOR_A = [
 0 0 0
 0 2 0
 0 0 0];

LOGOR_I = 1;
LOGOR_B = [
 0 0 0
 0 1 0
 0 0 0];


%****************************** LOGORN *****************************
%Function:	Logic OR function of the initial state and logic NOT function of the input.
%TemLibName:	LogicORwithNOT
%CNNModel:	Single-layer, CT-CNN
%Given:		Two static binary images P1 and P2
%Setting:	Input:P1, IniState:P2, Boundary:Fixed(0)
%Output:	Binary output of the logic operation OR between NOT P1 and P2.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Neighborhood:	1
LOGORN_A = [
0 0 0
0 2 0
0 0 0];

LOGORN_I = 1;
LOGORN_B = [
0 0 0
0 -1 0
0 0 0];


%****************************** LSE *****************************
%Function:	Local southern element detector.
%TemLibName:	LocalSouthernElementDetector
%CNNModel:	Single-layer, CT-CNN
%Given:		Static binary image P
%Setting:	Input:P, IniState:Arbitrary(0), Boundary:Fixed(0)
%Output:	Binary image representing local southern elements of objects in P.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%neighborhood: 1
LSE_A = [
0.0000   0.0000   0.0000
0.0000   1.0000   0.0000
0.0000   0.0000   0.0000];

LSE_B = [
0.0000   0.0000   0.0000   
0.0000   1.0000   0.0000   
-1.0000   -1.0000   -1.0000   ];

LSE_I = -3.0000;
%****************************** MAJVOT1 *****************************
%Function:	Majority vote-taker.
%TemLibName:	MajorityVoteTaker (Algorithm!)
%CNNModel:	Single-layer, CT-CNN
%Given:		Static binary image P
%Setting:	Input:P, IniState:P, Boundary:Fixed(0)
%Output:	Binary image (Phase 1).
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%neighborhood: 1
MAJVOT1_A = [
 0 0 0
 1 0 0
 0 0 0];

MAJVOT1_B = [
 0 0 0
 0 0.05 0
 0 0 0];

MAJVOT1_I = 0;
%****************************** MAJVOT3 *****************************
%Function:	Majority vote-taker (compares the sum in a local neigborhood to the specified threshold).
%TemLibName:	- ?
%CNNModel:	Single-layer, CT-CNN
%Given:		Static gray-scale image P
%Setting:	Input:P, IniState:Arbitrary(0), Boundary:Fixed(0)
%Output:	Binary image - black pixels mark those locations where the sum in local neighborhood (r=1) exceeds the specified threshold.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%neighborhood: 1
MAJVOT3_A = [
 0 0 0
 0 1 0
 0 0 0];

MAJVOT3_B = [
 1 1 1 
 1 1 1
 1 1 1];

MAJVOT3_I = -6.5;
%****************************** MATCH *****************************
%Function:	Finds matching patterns.
%TemLibName:	PatternMatchingFinder
%CNNModel:	Single-layer, CT-CNN
%Given:		Static binary image P possessing the 3x3 pattern prescribed by the template.
%Setting:	Input:P, IniState:Arbitrary(0), Boundary:Fixed(0)
%Output:	Binary image representing the locations of the 3x3 pattern prescribed by the template. The pattern having a black/white pixel where the template value is +1/-1, respectively, is detected.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Neighborhood:  1
MATCH_A = [
 0 0 0
 0 1 0
 0 0 0];

MATCH_I = -6.5;
MATCH_B = [
 1 -1 1
 0 1 0
 1 -1 1];


%****************************** MULLER *****************************
%Function:	Simulates the Müller-Lyer illusion.
%TemLibName:	MüllerLyerIllusion
%CNNModel:	Single-layer, CT-CNN
%Given:		Static binary image P representing two horizontal lines between arrows. The arrows are black, the background is white.
%Setting:	Input:P, IniState:P, Boundary:Fixed(0)
%Output:	Binary image showing that the horizontal line on the top in P seems to be longer than the other one.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Center-surround template simulating the Muller-Lyer illusion
%neighborhood: 1
MULLER_A = [
0 0 0
0  1.3 0
0 0 0];

MULLER_I = -2.8;
%neighborhood: 2
MULLER_B = [
-.1 -.1 -.1 -.1 -.1
-.1 -.1 -.1 -.1 -.1
-.1 -.1 1.3 -.1 -.1
-.1 -.1 -.1 -.1 -.1
-.1 -.1 -.1 -.1 -.1];


%****************************** PATCHMAK *****************************
%Function:	Patch maker.
%TemLibName:	PatchMaker
%CNNModel:	Single-layer, CT-CNN
%Given:		Static binary image P
%Setting:	Input:P, IniState:P, Boundary:Zero-flux
%Output:	Binary image with enlarged objects of P obtained after a certain time.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%NEIGHBORHOOD: 1
PATCHMAK_A = [
   0  1  0
   1  2  1
   0  1  0];

PATCHMAK_B = [
 0 0 0
 0 1 0
 0 0 0];

PATCHMAK_I = 4.5;
%****************************** PEEL1PIX *****************************
%Function:	Peel one pixel from all directions (#).
%TemLibName:	- ?
%CNNModel:	Single-layer, CT-CNN
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Neighborhood:	1
PEEL1PIX_A = [
 0  0.4	0
 0.4  1.4 0.4
 0  0.4	0];

PEEL1PIX_I = -7.2;
PEEL1PIX_B = [
 4.6  -2.8  4.6
 -2.8   1   -2.8
 4.6  -2.8  4.6];


%****************************** PEELHOR *****************************
%Function:	Peels one pixel from the left.
%TemLibName:	LeftPeeler
%CNNModel:	Single-layer, CT-CNN
%Given:		Static binary image P
%Setting:	Input:P, IniState:P, Boundary:Zero-flux
%Output:	Binary image representing the objects of P peeled with one pixel from the left.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%neighborhood: 1
PEELHOR_A = [
0.0000   0.0000   0.0000
0.0000   1.0000   0.0000
0.0000   0.0000   0.0000];

PEELHOR_B = [
0.0000   0.0000   0.0000   
1.0000   1.0000   0.0000   
0.0000   0.0000   0.0000   ];

PEELHOR_I = -1.0000;
%****************************** POISSON *****************************
%Function:	Solves the Poisson PDE (Dx = -f(x)).
%TemLibName:	PoissonPDESolver
%CNNModel:	Single-layer, CT-CNN
%Given:		Static gray-scale images P1 and P2 = -f(x)
%Setting:	Input:Arbitrary(0), IniState:P1, Boundary:Zero-flux, BiasMap:P2
%Output:	Gray-scale image - the solution of the Poisson equation.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%NEIGHBORHOOD: 1
POISSON_A = [
 0	1	0
 1	-3	1
 0	1	0];


%****************************** PROP1 *****************************
%Function:	Trigger-wave generator (expands the black regions).
%TemLibName:	-
%CNNModel:	Single-layer, CT-CNN
%Given:		Static binary image P
%Setting:	Input:-, IniState:P, Boundary:Zero-flux
%Output:	Binary image with enlarged objects of P obtained after a certain time.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%NEIGHBORHOOD: 1
PROP1_A = [
0.25	0.25	0.25	
0.25	3.0	0.25	
0.25	0.25	0.25	];


%****************************** PROP2 *****************************
%Function:	Trigger-wave generator (expands the white regions).
%TemLibName:	-
%CNNModel:	Single-layer, CT-CNN
%Given:		Static binary image P
%Setting:	Input:-, IniState:P, Boundary:Zero-flux
%Output:	Binary image with reduced objects of P obtained after a certain time.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%NEIGHBORHOOD: 1
PROP2_A = [
0.25	0.25	0.25	
0.25	3.0	0.25	
0.25	0.25	0.25	];


%****************************** RECALL *****************************
%Function:	Figure reconstruction from markers.
%TemLibName:	FigureReconstructor
%CNNModel:	Single-layer, CT-CNN
%Given:		Two static binary images P1 (mask) and P2 (marker)
%Setting:	Input:P1, IniState:P2, Boundary:Zero-flux
%Output:	Binary image representing those objects of P1 which are marked by P2.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%neighborhood: 1
RECALL_B = [
0.0   0.0   0.0
0.0   4.0   0.0
0.0   0.0   0.0];

RECALL_A = [
0.5 0.5 0.5
0.5 4.0 0.5
0.5 0.5 0.5];

RECALL_I = 2.5;
%****************************** RIGHTBC *****************************
%Function:	Right (diagonal) contour detection (#).
%TemLibName:	- ?
%CNNModel:	Single-layer, CT-CNN
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%neighborhood: 1
RIGHTBC_A = [
0.0000	 0.0000   0.0000
0.0000	 1.0000   0.0000
0.0000	 0.0000   0.0000];

RIGHTBC_B = [
1.0000	 0.0000   0.0000
0.0000	 1.0000    0.0000
0.0000	 0.0000  -1.0000];

RIGHTBC_I = -2.0000;
%****************************** RIGHTCON *****************************
%Function:	Right contour detector.
%TemLibName:	RightContourDetector
%CNNModel:	Single-layer, CT-CNN
%Given:		Static binary image P
%Setting:	Input:P, IniState:P, Boundary:Fixed(0)
%Output:	Binary image representing the right edges of objects in P.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%neighborhood: 1
RIGHTCON_A = [
0.0000   0.0000   0.0000
0.0000   1.0000   0.0000
0.0000   0.0000   0.0000];

RIGHTCON_B = [
0.0000   0.0000   0.0000   
1.0000   1.0000   -1.0000   
0.0000   0.0000   0.0000   ];

RIGHTCON_I = -2.0000;
%****************************** SHADMASK *****************************
%Function:	Creates a masked right shadow of the object.
%TemLibName:	MaskedShadow
%CNNModel:	Single-layer, CT-CNN
%Given:		Static binary images P1 and P2
%Setting:	Input:P1, IniState:P2, Boundary:Fixed(-1)
%Output:	Binary image representing the result of pattern propagation of P2 in a particular direction. The propagation goes from the direction of the non-zero off-center feedback template entry and is halted by the mask P1.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Neighborhood: 1
SHADMASK_A = [
0   0   0
0  1.8 1.5
0   0   0];

SHADMASK_I = 0;
SHADMASK_B = [
0   0   0
0 -1.2  0
0   0   0];


%****************************** SHADOW *****************************
%Function:	Creates the left shadow of the object.
%TemLibName:	LeftShadow
%CNNModel:	Single-layer, CT-CNN
%Given:		Static binary image P
%Setting:	Input:P, IniState:1, Boundary:Fixed(0)
%Output:	Binary image representing the left shadow of the objects in P.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Neighborhood: 1
SHADOW_A = [
0 0 0
0 2 2
0 0 0];

SHADOW_I = 0;
SHADOW_B = [
0 0 0
0 2 0
0 0 0];


%****************************** SHADSIM *****************************
%Function:	Creates a vertical shadow of the object (in both directions).
%TemLibName:	VerticalShadow
%CNNModel:	Single-layer, CT-CNN
%Given:		Static binary image P
%Setting:	Input:P, IniState:P, Boundary:Zero-flux
%Output:	Binary image representing the vertical shadow of the objects in P taken upward and downward simultaneously.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Neighborhood: 1
SHADSIM_A = [
0  1  0
0  2  0
0  1  0];

SHADSIM_I = 2;
%****************************** SHIFTE *****************************
%Function:	Shifts the image toward eastern direction.
%TemLibName:	- ?
%CNNModel:	Single-layer, CT-CNN
%Given:		Static binary image P
%Setting:	Input:P, IniState:0, Boundary:Zero-flux
%Output:	Binary image - P is shifted toward the eastern direction by one pixel.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%NEIGHBORHOOD: 1
SHIFTE_B = [
0	0	0
1	0	0
0	0	0];

SHIFTE_A = [
0	0	0
0	2	0
0	0	0];


%****************************** SHIFTN *****************************
%Function:	Shifts the image toward northern direction.
%TemLibName:	- ?
%CNNModel:	Single-layer, CT-CNN
%Given:		Static binary image P
%Setting:	Input:P, IniState:0, Boundary:Zero-flux
%Output:	Binary image - P is shifted toward the northern direction by one pixel.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%NEIGHBORHOOD: 1
SHIFTN_B = [
0	0	0
0	0	0
0	1	0];

SHIFTN_A = [
0	0	0
0	2	0
0	0	0];


%****************************** SHIFTNE *****************************
%Function:	Shifts the image toward north-estern direction.
%TemLibName:	- ?
%CNNModel:	Single-layer, CT-CNN
%Given:		Static binary image P
%Setting:	Input:P, IniState:0, Boundary:Zero-flux
%Output:	Binary image - P is shifted toward the north-estern direction by one pixel.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%NEIGHBORHOOD: 1
SHIFTNE_B = [
0	0	0
0	0	0
1	0	0];

SHIFTNE_A = [
0	0	0
0	2	0
0	0	0];


%****************************** SHIFTNW *****************************
%Function:	Shifts the image toward north-western direction.
%TemLibName:	- ?
%CNNModel:	Single-layer, CT-CNN
%Given:		Static binary image P
%Setting:	Input:P, IniState:0, Boundary:Zero-flux
%Output:	Binary image - P is shifted toward the north-western direction by one pixel.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%NEIGHBORHOOD: 1
SHIFTNW_B = [
0	0	0
0	0	0
0	0	1];

SHIFTNW_A = [
0	0	0
0	2	0
0	0	0];


%****************************** SHIFTS *****************************
%Function:	Shifts the image toward southern direction.
%TemLibName:	- ?
%CNNModel:	Single-layer, CT-CNN
%Given:		Static binary image P
%Setting:	Input:P, IniState:0, Boundary:Zero-flux
%Output:	Binary image - P is shifted toward the southern direction by one pixel.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%NEIGHBORHOOD: 1
SHIFTS_B = [
0	1	0
0	0	0
0	0	0];

SHIFTS_A = [
0	0	0
0	2	0
0	0	0];

%****************************** SHIFTSE *****************************
%Function:	Shifts the image toward south-estern direction.
%TemLibName:	- ?
%CNNModel:	Single-layer, CT-CNN
%Given:		Static binary image P
%Setting:	Input:P, IniState:0, Boundary:Zero-flux
%Output:	Binary image - P is shifted toward the south-estern direction by one pixel.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%NEIGHBORHOOD: 1
SHIFTSE_B = [
1	0	0
0	0	0
0	0	0];

SHIFTSE_A = [
0	0	0
0	2	0
0	0	0];


%****************************** SHIFTSW *****************************
%Function:	Shifts the image toward south-western direction.
%TemLibName:	- ?
%CNNModel:	Single-layer, CT-CNN
%Given:		Static binary image P
%Setting:	Input:P, IniState:0, Boundary:Zero-flux
%Output:	Binary image - P is shifted toward the south-western direction by one pixel.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%NEIGHBORHOOD: 1
SHIFTSW_B = [
0	0	1
0	0	0
0	0	0];

SHIFTSW_A = [
0	0	0
0	2	0
0	0	0];


%****************************** SHIFTW *****************************
%Function:	Shifts the image toward western direction.
%TemLibName:	- ?
%CNNModel:	Single-layer, CT-CNN
%Given:		Static binary image P
%Setting:	Input:P, IniState:0, Boundary:Zero-flux
%Output:	Binary image - P is shifted toward the western direction by one pixel.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%NEIGHBORHOOD: 1
SHIFTW_B = [
0	0	0
0	0	1
0	0	0];

SHIFTW_A = [
0	0	0
0	2	0
0	0	0];


%****************************** SKELBW1 *****************************
%Function:	The algorithm finds the skeleton of a black-and-white object.
%TemLibName:	BlackandWhiteSkeletonization (Algorithm!)
%CNNModel:	Single-layer, CT-CNN
%Given:		Static binary image P
%Setting:	Input:P, IniState:Arbitrary(0), Boundary:Zero-flux
%Output:	Binary image (Phase 1 of the skeletonization algorithm).
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%neighborhood: 1
SKELBW1_A = [
0   0   0
0   1   0
0   0   0];

SKELBW1_B = [
1   1   0   
1   7   -1   
0   -1   0   ];

SKELBW1_I = -3;
%****************************** SKELBW2 *****************************
%Function:	The algorithm finds the skeleton of a black-and-white object.
%TemLibName:	BlackandWhiteSkeletonization (Algorithm!)
%CNNModel:	Single-layer, CT-CNN
%Given:		Static binary image P
%Setting:	Input:P, IniState:Arbitrary(0), Boundary:Zero-flux
%Output:	Binary image (Phase 2 of the skeletonization algorithm).
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%neighborhood: 1
SKELBW2_A = [
0   0   0
0   1   0
0   0   0];

SKELBW2_B = [
 1    1   1   
 0    7   0   
-0.5 -1  -0.5   ];

SKELBW2_I = -3.4;
%****************************** SKELBW3 *****************************
%Function:	The algorithm finds the skeleton of a black-and-white object.
%TemLibName:	BlackandWhiteSkeletonization (Algorithm!)
%CNNModel:	Single-layer, CT-CNN
%Given:		Static binary image P
%Setting:	Input:P, IniState:Arbitrary(0), Boundary:Zero-flux
%Output:	Binary image (Phase 3 of the skeletonization algorithm).
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%neighborhood: 1
SKELBW3_A = [
0   0   0
0   1   0
0   0   0];

SKELBW3_B = [
 0   1   1   
-1   7   1   
 0  -1   0   ];

SKELBW3_I = -3;
%****************************** SKELBW4 *****************************
%Function:	The algorithm finds the skeleton of a black-and-white object.
%TemLibName:	BlackandWhiteSkeletonization (Algorithm!)
%CNNModel:	Single-layer, CT-CNN
%Given:		Static binary image P
%Setting:	Input:P, IniState:Arbitrary(0), Boundary:Zero-flux
%Output:	Binary image (Phase 4 of the skeletonization algorithm).
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%neighborhood: 1
SKELBW4_A = [
0   0   0
0   1   0
0   0   0];

SKELBW4_B = [
 -0.5   0   1   
 -1     7   1   
 -0.5   0   1   ];

SKELBW4_I = -3.4;
%****************************** SKELBW5 *****************************
%Function:	The algorithm finds the skeleton of a black-and-white object.
%TemLibName:	BlackandWhiteSkeletonization (Algorithm!)
%CNNModel:	Single-layer, CT-CNN
%Given:		Static binary image P
%Setting:	Input:P, IniState:Arbitrary(0), Boundary:Zero-flux
%Output:	Binary image (Phase 5 of the skeletonization algorithm).
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%neighborhood: 1
SKELBW5_A = [
0   0   0
0   1   0
0   0   0];

SKELBW5_B = [
0   -1   0   
-1   7   1   
0    1   1   ];

SKELBW5_I = -3;
%****************************** SKELBW6 *****************************
%Function:	The algorithm finds the skeleton of a black-and-white object.
%TemLibName:	BlackandWhiteSkeletonization (Algorithm!)
%CNNModel:	Single-layer, CT-CNN
%Given:		Static binary image P
%Setting:	Input:P, IniState:Arbitrary(0), Boundary:Zero-flux
%Output:	Binary image (Phase 6 of the skeletonization algorithm).
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%neighborhood: 1
SKELBW6_A = [
0   0   0
0   1   0
0   0   0];

SKELBW6_B = [
-0.5   -1  -0.5
  0     7    0   
  1     1    1   ];

SKELBW6_I = -3.4;
%****************************** SKELBW7 *****************************
%Function:	The algorithm finds the skeleton of a black-and-white object.
%TemLibName:	BlackandWhiteSkeletonization (Algorithm!)
%CNNModel:	Single-layer, CT-CNN
%Given:		Static binary image P
%Setting:	Input:P, IniState:Arbitrary(0), Boundary:Zero-flux
%Output:	Binary image (Phase 7 of the skeletonization algorithm).
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%neighborhood: 1
SKELBW7_A = [
0   0   0
0   1   0
0   0   0];

SKELBW7_B = [
0   -1   0   
1    7  -1   
1    1   0   ];

SKELBW7_I = -3;
%****************************** SKELBW8 *****************************
%Function:	The algorithm finds the skeleton of a black-and-white object.
%TemLibName:	BlackandWhiteSkeletonization (Algorithm!)
%CNNModel:	Single-layer, CT-CNN
%Given:		Static binary image P
%Setting:	Input:P, IniState:Arbitrary(0), Boundary:Zero-flux
%Output:	Binary image (Phase 8 of the skeletonization algorithm).
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%neighborhood: 1
SKELBW8_A = [
0   0   0
0   1   0
0   0   0];

SKELBW8_B = [
1   0  -0.5
1   7  -1   
1   0  -0.5   ];

SKELBW8_I = -3.4;
%****************************** SMKILLER *****************************
%Function:	Deletes small objects.
%TemLibName:	SmallObjectRemover
%CNNModel:	Single-layer, CT-CNN
%Given:		Static binary image P
%Setting:	Input:-, IniState:P, Boundary:Fixed(0)
%Output:	Binary image representing P without small objects.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%NEIGHBORHOOD: 1
SMKILLER_A = [
 1  1  1
 1  2  1
 1  1  1];


%****************************** T1_RACC3 *****************************
%Function:	Textures detection.
%TemLibName:	3x3TextureSegmentation
%CNNModel:	Single-layer, CT-CNN
%Given:		Static gray-scale image P representing textures having the same flat grayscale histograms
%Setting:	Input:P, IniState:P, Boundary:Fixed(0)
%Output:	Nearly binary image where the detected texture becomes darker than the others.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%neighborhood: 1
T1_RACC3_A = [
   2.2656    1.7969    3.3594 
  -0.7031   -4.4531    1.4063 
   3.2031    3.9844   -0.3125 ];

T1_RACC3_I = -1.6406;
T1_RACC3_B = [
  -3.9063    1.2500    3.0469 
   0.8594   -3.0469    3.3594 
   1.7188   -0.6250   -4.6094 ];

%****************************** T2_RACC3 *****************************
%Function:	Textures detection.
%TemLibName:	3x3TextureSegmentation
%CNNModel:	Single-layer, CT-CNN
%Given:		Static gray-scale image P representing textures having the same flat grayscale histograms
%Setting:	Input:P, IniState:P, Boundary:Fixed(0)
%Output:	Nearly binary image where the detected texture becomes darker than the others.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%neighborhood: 1
T2_RACC3_A = [
   1.5625    4.3750    2.4219 
   4.6875   -3.1250    1.4063 
   2.1875   -5.0000    0.8594 ];

T2_RACC3_I = -3.2031;
T2_RACC3_B = [
  -2.8125    2.4219   -3.7500 
  -5.0000   -0.3906   -5.0000 
   3.6719    4.2188    3.1250 ];

%****************************** T3_RACC3 *****************************
%Function:	Textures detection.
%TemLibName:	3x3TextureSegmentation
%CNNModel:	Single-layer, CT-CNN
%Given:		Static gray-scale image P representing textures having the same flat grayscale histograms
%Setting:	Input:P, IniState:P, Boundary:Fixed(0)
%Output:	Nearly binary image where the detected texture becomes darker than the others.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%neighborhood: 1
T3_RACC3_A = [
   1.6406   -1.0156    1.3281 
   1.8750   -4.6094    2.8906 
   3.2813    2.0313    3.7500 ];

T3_RACC3_I = -2.4219;
T3_RACC3_B = [
  -3.9063   -2.6563   -3.1250 
   0.9375    1.4844   -3.1250 
   1.3281    0.5469    2.3438 ];

%****************************** T4_RACC3 *****************************
%Function:	Textures detection.
%TemLibName:	3x3TextureSegmentation
%CNNModel:	Single-layer, CT-CNN
%Given:		Static gray-scale image P representing textures having the same flat grayscale histograms
%Setting:	Input:P, IniState:P, Boundary:Fixed(0)
%Output:	Nearly binary image where the detected texture becomes darker than the others.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%neighborhood: 1
T4_RACC3_A = [
   3.1250    4.2969    2.1875 
  -2.8125    3.1250    0.1563 
   1.8750    4.9219    4.5313 ];

T4_RACC3_I = -2.4219;
T4_RACC3_B = [
  -3.5156    4.3750   -5.0000 
  -0.9375   -3.0469   -3.6719 
   1.4063   -0.6250   -4.3750 ];

%****************************** TEXTUDIL *****************************
%Function:	Dilation (algo#).
%TemLibName:	- ?
%CNNModel:	Single-layer, CT-CNN
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%NEIGHBORHOOD: 1
TEXTUDIL_A = [
0  0  0
0  0  0
0  0  0];

TEXTUDIL_B = [
 0   1	  0
 1   1	  1
 0   1	  0];

TEXTUDIL_I = 4;
%****************************** TEXTUERO *****************************
%Function:	Erosion (algo#).
%TemLibName:	- ?
%CNNModel:	Single-layer, CT-CNN
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%NEIGHBORHOOD: 1
TEXTUERO_A = [
0  0  0
0  0  0
0  0  0];

TEXTUERO_B = [
 0   1	  0
 1   1	  1
 0   1	  0];

TEXTUERO_I = -4;
%****************************** THRES *****************************
%Function:	Grayscale to binary threshold template
%TemLibName:	Threshold
%CNNModel:	Single-layer, CT-CNN
%Given:		Static gray-scale image P
%Setting:	Input:-, IniState:P, Boundary:Fixed(0)
%Output:	Binary image where black pixels correspond to pixels in P with grayscale intensity above the given threshold.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%NEIGHBORHOOD: 1
THRES_A = [
  0.000  0.000  0.000
  0.000  2.000  0.000
  0.000  0.000  0.000];

THRES_I = -0.4;
%****************************** TRESHOLD *****************************
%Function:	Grayscale to binary threshold template
%TemLibName:	Threshold
%CNNModel:	Single-layer, CT-CNN
%Given:		Static gray-scale image P
%Setting:	Input:-, IniState:P, Boundary:Fixed(0)
%Output:	Binary image where black pixels correspond to pixels in P with grayscale intensity above the given threshold.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Neighborhood: 1
TRESHOLD_A = [
 0 0 0   
 0 2 0   
 0 0 0];

TRESHOLD_I = -0.4;
%****************************** TX_HCLC *****************************
%Function:	Segmentation of four textures.
%TemLibName:	5x5TextureSegmentation1
%CNNModel:	Single-layer, CT-CNN
%Given:		Static gray-scale image P representing four textures
%Setting:	Input:P, IniState:P, Boundary:Fixed(0)
%Output:	Nearly binary image representing four patterns that differ in average gray-levels.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%neighborhood: 2
TX_HCLC_A = [
  -3.4375    0.8594   -1.6406   -0.1563   -1.0156 
  -1.0938    0.1563   -2.1875   -3.2031    3.5156 
   2.5000    1.5625    3.9063    2.6563    2.4219 
   0.5469    2.8906   -0.6250    0.4688    3.6719 
  -1.7969   -0.5469    2.5000   -0.2344    2.3438 ];

TX_HCLC_I = 3.2813;
TX_HCLC_B = [
  -2.1875   -0.2344    0.1563   -0.6250   -0.7813 
   1.6406    2.2656   -3.2031    1.0938    2.0313 
   0.0781    0.5469    0.8594    3.5156    0.0781 
   0.3906   -3.8281   -3.1250   -2.3438   -2.1094 
   0.7813   -2.6563   -1.1719   -1.4063    1.0156 ];

%****************************** TX_RACC3 *****************************
%Function:	Segmentation of four textures.
%TemLibName:	3x3TextureSegmentation
%CNNModel:	Single-layer, CT-CNN
%Given:		Static gray-scale image P representing four textures
%Setting:	Input:P, IniState:P, Boundary:Fixed(0)
%Output:	Nearly binary image representing four patterns that differ in average gray-levels.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%neighborhood: 1
TX_RACC3_A = [
   0.8594    0.9375    3.7500 
   2.1094   -2.8125    3.7500 
  -1.3281   -2.5781   -1.0156 ];

TX_RACC3_I = 1.7969;
TX_RACC3_B = [
   0.1563   -1.5625    1.2500 
  -2.8906    1.0938   -3.2031 
   4.0625    4.6875    3.7500 ];

%****************************** TX_RACC5 *****************************
%Function:	Segmentation of four textures.
%TemLibName:	5x5TextureSegmentation2
%CNNModel:	Single-layer, CT-CNN
%Given:		Static gray-scale image P representing four textures
%Setting:	Input:P, IniState:P, Boundary:Fixed(0)
%Output:	Nearly binary image representing four patterns that differ in average gray-levels.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%neighborhood: 2
TX_RACC5_A = [
   4.2188   -1.5625    1.5625    3.3594    0.6250 
  -2.8906    4.5313   -0.2344    3.1250   -2.8906 
   2.6563    2.1875   -4.6875   -3.4375   -2.8125 
   3.9844    1.5625   -1.1719   -3.1250   -3.2031 
  -3.7500   -2.1875    3.2813    2.1875   -0.6250 ];

TX_RACC5_I = -5.0000;
TX_RACC5_B = [
   4.0625   -5.0000    0.3906    2.1094   -1.8750 
   3.9063    0.3125   -1.9531    4.8438   -0.3125 
   0.0000   -4.0625    0.9375   -0.3125    0.4688 
  -0.6250   -5.0000    2.3438    0.6250   -1.8750 
   3.5938   -0.9375    0.1563    2.8125   -1.8750 ];

%****************************** VERSKELB *****************************
%Function:	Vertical skeleton from the bottom.
%TemLibName:	VerSkelB
%CNNModel:	Single-layer, CT-CNN
%Given:		Static binary image P
%Setting:	Input:P, IniState:Arbitrary(0), Boundary:Fixed(0)
%Output:	Binary image, peeling the black pixels from the bottom of the object.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%NEIGHBORHOOD: 1
VERSKELB_A = [
0  0  0
0  3  0
0  0  0];

VERSKELB_B = [
0.125  -0.5  0.125
0   0.5  0
0.5  -0.5  0.5];

VERSKELB_I = -1;
%****************************** VERSKELT *****************************
%Function:	Vertical skeleton from the top.
%TemLibName:	VerSkelT
%CNNModel:	Single-layer, CT-CNN
%Given:		Static binary image P
%Setting:	Input:P, IniState:Arbitrary(0), Boundary:Fixed(0)
%Output:	Binary image, peeling the black pixels from the top of the object.
%Timing:	-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%NEIGHBORHOOD: 1
VERSKELT_A = [
0  0  0
0  3  0
0  0  0];

VERSKELT_B = [
0.5 0.5 0.5
0 0.5 0
0.125 -0.5 0.125];

VERSKELT_I = -1;