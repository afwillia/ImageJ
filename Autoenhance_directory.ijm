// this script takes a directory of images as input and for each image:
// splits the images into blue, green, and red channels
// subtracts background and enhances images
// then merges channels into one and saves as JPG in directory chosen by user

// get input and output directories
print("Select INPUT Directory");
input = getDirectory("Choose a Directory");
run("Close");
print("Select OUTPUT Directory");
output = getDirectory("Choose a Directory");
run("Close");

// loop through each image in directory
setBatchMode(true);
list = getFileList(input);
for (i = 0; i < list.length; i++)
        action(input, output, list[i]);
setBatchMode(false);

// this function takes each image, splits the channels. Adjusts R G and B channels, then merges as saves as jpg.
function action(input, output, filename) { 
	open(input + filename);
	filename = getTitle();
	run("Split Channels");

	selectWindow(filename + " (green)");
	titleGreen = getTitle();
	run("Subtract Background...", "rolling=15");
	run("Enhance Contrast", "saturated=0.01");

	selectWindow(filename + " (red)");
	titleRed = getTitle();
	run("Subtract Background...", "rolling=15");
	run("Enhance Contrast", "saturated=0.01");

	selectWindow(filename + " (blue)");
	titleBlue = getTitle();
	run("Subtract Background...", "rolling=15");
	run("Enhance Contrast", "saturated=0.01");

	run("Merge Channels...", "c1=titleRed c2=titleGreen c3=titleBlue create");
	saveAs("Jpeg", output + filename);
	close();
}

