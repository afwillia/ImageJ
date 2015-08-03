// get input and output directories
print("Select INPUT Directory");
input = getDirectory("Choose a Directory");
run("Close");

// loop through each image in directory
setBatchMode(true);
list = getFileList(input);
for (i = 0; i < list.length; i++)
        action(input, list[i]);
setBatchMode(false);

function action(input, filename) {
	open(input + filename);
	filename = getTitle();
	run("Split Channels");

	//red channel
	selectWindow(filename + " (red)");
	run("Find Maxima...", "noise=75 output=Count exclude");
	selectWindow(filename + " (red)");
	close();

	//green channel
	selectWindow(filename + " (green)");
	run("Find Maxima...", "noise=65 output=Count exclude");
	selectWindow(filename + " (green)");
	close();

	// select blue channel to close
	selectWindow(filename + " (blue)");
	close();
}

