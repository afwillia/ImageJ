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
	//set image size to microns
	run("Properties...", "channels=1 slices=1 frames=1 unit=micron pixel_width=1.01 pixel_height=1.01 voxel_depth=1.01");

	run("8-bit");
	setAutoThreshold("Triangle dark");
	run("Threshold...");
	//getThreshold(lower, upper);
	//setThreshold(2, 255);
	run("Convert to Mask");
	run("Fill Holes");
	// measure large particles, i.e. biopsy
	run("Analyze Particles...", "size=100000-Infinity show=Nothing display");

}
