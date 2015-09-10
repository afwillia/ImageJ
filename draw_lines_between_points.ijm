// this macro draws lines between coordinates in a file

pathfile=File.openDialog("Choose the file to Open:");
filestring=File.openAsString(pathfile);

rows=split(filestring, "\n");
cell_x=newArray(rows.length);
cell_y=newArray(rows.length);
dej_x=newArray(rows.length);
dej_y=newArray(rows.length);

for(i=0; i<rows.length; i++)
{
	columns=split(rows[i],",");
	cell_x[i]=parseInt(columns[0]);
	cell_y[i]=parseInt(columns[1]);
	dej_x[i]=parseInt(columns[2]);
	dej_y[i]=parseInt(columns[3]);
	
	drawLine(cell_x[i], cell_y[i],dej_x[i], dej_y[i]);
}
