//////////////////////////////////////////////////////////////////////////////
/// May 2009
/// Bryan Schnabel
/// xliffRoundTrip Tool version 0.7
/// (c) Copyright Bryan Schnabel
/// 
/// Apache License\
/// Version 2.0, January 2004
/// http://www.apache.org/licenses/ 
//////////////////////////////////////////////////////////////////////////////
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamSource;
import javax.xml.transform.stream.StreamResult;
////////////////
import java.io.*;
import java.awt.*;
import javax.swing.*;
import java.awt.event.*;

public class xrtV07 extends JFrame implements ActionListener
{
    JFileChooser jfilechooser = new JFileChooser();
    JOptionPane frameXRTrip1 = new JOptionPane();
    Image img = Toolkit.getDefaultToolkit().getImage("xrtt.gif");
    JButton buttonRoundTripper0 = new JButton("Choose XML file to transform to XLIFF");
    JTextField textXRTrip0 = new JTextField(25);
    JButton buttonRoundTripper1 = new JButton("Choose XLIFF file to transform to XML");
    JToggleButton XRTripToggleButton = new JToggleButton("About xliffRoundTrip Tool");
    ActionListener togListener = new ActionListener() {
      public void actionPerformed(ActionEvent actionEvent) {
        AbstractButton abstractButton = (AbstractButton) actionEvent.getSource();
        boolean selected = abstractButton.getModel().isSelected();
       JOptionPane.showMessageDialog(frameXRTrip1, " xliffRoundTrip Tool version 0.7\n Copyright (C) 2003, 2009 Bryan Schnabel\n Apache License\n Version 2.0, January 2004\n http://www.apache.org/licenses/ ");
      }
    };

    JTextField textXRTrip1 = new JTextField(25);
    JTextField textXRTrip2 = new JTextField(25);
    JTextField textXRTrip3 = new JTextField(25);
    Button buttonXRTrip1, buttonXRTrip2;
    String accounts[];

    String xmlInputFile = new String("  some.xml");
    static String xliffInputFile = new String(" some.xlf");

    String xliffRoundTrip = new String("xliffRoundTrip ");
    String xsl4xml2xliff = new String("  xml2xliff.xsl");
    String xsl4xliff2xml = new String(" xliff2xml.xsl");
        FileWriter filewriter2;

    public xrtV07() 
    {
        super(); 
        setTitle("xliffRoundTrip Tool");
        
        Container contentPane = getContentPane();

        contentPane.setLayout(new FlowLayout());
        setIconImage(img);
        contentPane.add(buttonRoundTripper0);        
        contentPane.add(textXRTrip0); 
        buttonRoundTripper0.addActionListener(this); 

        contentPane.add(buttonRoundTripper1);  
        contentPane.add(textXRTrip1); 
        buttonRoundTripper1.addActionListener(this);  
 
        contentPane.add(XRTripToggleButton);
        XRTripToggleButton.addActionListener(togListener);

        
        jfilechooser.addChoosableFileFilter(new filter1());
        jfilechooser.addChoosableFileFilter(new filter2());
        JOptionPane.showMessageDialog(frameXRTrip1, " xliffRoundTrip Tool version 0.7\n Copyright (C) 2003, 2009 Bryan Schnabel\n Apache License\n Version 2.0, January 2004\n http://www.apache.org/licenses/ ");
    }

    public void actionPerformed(ActionEvent e) 
    {

        textXRTrip0.setText("working! [XML filename will display here]");
        textXRTrip1.setText("working! [XLIFF filename will display here]");

//        int result = jfilechooser.showOpenDialog(null);
// May 2009 - change this to a button that indicates the transform is taking place
          int result = jfilechooser.showDialog (this, "Transform");

	if(e.getSource() == buttonRoundTripper0) {

		if(result == JFileChooser.APPROVE_OPTION) {

            		textXRTrip0.setText(jfilechooser.getSelectedFile().getPath());
                        String xmlInputFile = (jfilechooser.getSelectedFile().getPath());
            		textXRTrip1.setText(jfilechooser.getSelectedFile().getPath()+".xlf");

				File InputFile = new File(xmlInputFile);
				File xliffXSLTfile = new File("xml2xliff.xsl");

				Source xmlIn = new StreamSource(InputFile);
				Source xliffRoundTripXSL = new StreamSource(xliffXSLTfile);
				TransformerFactory transFact =
				TransformerFactory.newInstance();


			try {  
				Transformer trans = transFact.newTransformer(xliffRoundTripXSL);
				trans.transform(xmlIn, new StreamResult(InputFile + ".xlf"));
					}
			catch(Exception ioe) {  
				System.err.println("Could not transform; malformed? ..." + xmlInputFile);
					}


				}
       			}

	if(e.getSource() == buttonRoundTripper1) {
		if(result == JFileChooser.APPROVE_OPTION) {
            		textXRTrip1.setText(jfilechooser.getSelectedFile().getPath());
                        String xliffInputFile = (jfilechooser.getSelectedFile().getPath());
            		textXRTrip0.setText(jfilechooser.getSelectedFile().getPath()+".xml");

				File InputFile = new File(xliffInputFile);
				File xliffXSLTfile = new File("xliff2xml.xsl");

				Source xmlIn = new StreamSource(InputFile);
				Source xliffRoundTripXSL = new StreamSource(xliffXSLTfile);
				TransformerFactory transFact =
				TransformerFactory.newInstance();


			try {  
				Transformer trans = transFact.newTransformer(xliffRoundTripXSL);
				trans.transform(xmlIn, new StreamResult(InputFile + ".xml"));
					}
			catch(Exception ioe) {  
				System.err.println("Could not transform; malformed?" + xliffInputFile);
					}

				}
			}
    }

    public static void main(String a[]) 
    {
        JFrame jframe = new xrtV07();

        jframe.setBounds(200, 200, 300, 300);

        jframe.setVisible(true);

        jframe.setDefaultCloseOperation(
            WindowConstants.DISPOSE_ON_CLOSE);

        jframe.addWindowListener(new WindowAdapter() {
//added May 2009 '@Override'
            @Override
            public void windowClosing(WindowEvent e) 
            {
                System.exit(0);
            }
        });
    }

}


class filter1 extends javax.swing.filechooser.FileFilter 
{
    public boolean accept(File fileobj) 
    {
        String extension = "";

        if(fileobj.getPath().lastIndexOf('.') > 0)
            extension = fileobj.getPath().substring(
                fileobj.getPath().lastIndexOf('.') 
                + 1).toLowerCase();

        if(extension != "")
            return extension.equals("xlf");
        else
            return fileobj.isDirectory();
    }

    public String getDescription() 
    {
        return "XLIFF file (*.xlf)";
    }
}

class filter2 extends javax.swing.filechooser.FileFilter 
{
    public boolean accept(File fileobj) 
    {
        String extension = "";

        if(fileobj.getPath().lastIndexOf('.') > 0)
            extension = fileobj.getPath().substring(
                fileobj.getPath().lastIndexOf('.') 
                + 1).toLowerCase();

        if(extension != "")
            return extension.equals("xml");
        else
            return fileobj.isDirectory();
    }

    public String getDescription() 
    {
        return "xml file (*.xml)";
    }

}
//////////////
class clxrtV07 {

	public static void main(String[] args) throws Exception {
		if (args.length != 2) {
			System.err.println(
			"Usage: java xliffRoundTrip [xmlfile] [xslfile] > [outputfile]");
		System.exit(1);
		}

	File InputFile = new File(args[0]);
	File xliffXSLTfile = new File(args[1]);

	Source xmlIn = new StreamSource(InputFile);
	Source xliffRoundTripXSL = new StreamSource(xliffXSLTfile);

	TransformerFactory transFact =
	TransformerFactory.newInstance();
	Transformer trans = transFact.newTransformer(xliffRoundTripXSL);
	trans.transform(xmlIn, new StreamResult(System.out));
	}
}


