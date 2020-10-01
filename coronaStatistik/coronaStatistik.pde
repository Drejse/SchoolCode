import java.lang.NullPointerException;
import org.gicentre.utils.stat.*;    // For chart classes.
String[] date;
int[] cases;
int[] death;
String[] tmpArr = new String[4]; //Set arraysize to the amount of columns in imported file
String[] data;
float[] x;
XYChart lineChart;


void setup()
{
  size(1000, 500);
  textFont(createFont("Arial", 10), 10);
  readCovidData();
  //printCases();
  lineChart = new XYChart(this);
  drawChart(cases); //Data to show
  displayChart("Cases"); //Description
  
}

void readCovidData()
{
  try {
    //Imports data to Strings and sets array sizes according to the data length
    data = loadStrings("covid19_data.csv"); //Insert filename <-
    date = new String[data.length];
    cases = new int[data.length];
    death = new int[data.length];
    x = new float [data.length]; //Used for chart creation

    //Splits the data array strings into the date,cases and death arrays
    for (int i = 1; i < data.length; i++)
    {
      tmpArr = split(data[i], ';');
      date[i] = tmpArr[0];
      cases[i] = Integer.parseInt(tmpArr[1]);
      death[i] = Integer.parseInt(tmpArr[2]);
      x[i] = i; //Used for chart creation
    }
  } 
  catch (NullPointerException e) {
    println("No file " + e);
  }
}

void printCases ()
{
  
  //Used for printing the rows together
  for (int i = 0; i < date.length; i++)
  {
    println("Date: " + date[i] + "\t" +
      "Cases: " + cases[i] + "\t" +
      " Death: " + death[i]);
      
  }
}

void drawChart (int tmpArr[])
{
  // Both x and y data set here.  
  lineChart.setData(reverse(x),float(tmpArr));
                   
  
  // Axis formatting and labels.
  lineChart.showXAxis(true); 
  lineChart.showYAxis(true); 
  lineChart.setMinY(0);
  lineChart.setXAxisLabel("Days from 25-02-2020");
  
  
  // Symbol colours
  lineChart.setPointColour(color(180,50,50,100));
  lineChart.setPointSize(5);
  lineChart.setLineWidth(2);

}

void displayChart (String tmpStr)
{
  background(255);
  textSize(9);
  lineChart.draw(15,15,width-30,height-30);
  
  // Draw a title over the top of the chart.
  fill(120);
  textSize(20);
  text("Covid19 " + tmpStr, 70,30);
}
