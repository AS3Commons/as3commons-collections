import java.io.File;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class EmbedExamples {

	String path_sources;
	String path_examples;
	
	public EmbedExamples(String sources, String examples) {
		path_sources = sources;
		path_examples = examples;
		
		embedExamples(new File(path_sources));
	}
	
	public void embedExamples(File dir) {
		File[] files = dir.listFiles();

		if (files != null) {
			for (int i = 0; i < files.length; i++) {
				if (files[i].isDirectory()) {
					embedExamples(files[i]); // ruft sich selbst mit dem 

				} else {
					String content = FileUtils.readFile(files[i].getAbsolutePath());
					
					Pattern p = Pattern.compile("\\{\\{EXAMPLE: (.*)\\}\\}");
					Matcher m = p.matcher(content);
					
					Boolean matches = false;
					StringBuffer myStringBuffer = new StringBuffer();
					while (m.find()){
						m.appendReplacement(myStringBuffer, computeReplacementString(m.group(1)));
						System.out.println("Embed example " + m.group(1) + " in " + files[i].getAbsolutePath());
						matches = true;
					}
					m.appendTail(myStringBuffer);
					
					if (matches) {
						FileUtils.writeFile(files[i].getAbsolutePath(), myStringBuffer.toString());
					}
					
				}
			}
		}


	}
	
	public String computeReplacementString(String className) {
		Pattern p = Pattern.compile("\\.");
		Matcher m = p.matcher(className);
		String path = path_examples + "/" + m.replaceAll("/") + ".as";
		
		String content = FileUtils.readFile(path);
		p = Pattern.compile("\t");
		m = p.matcher(content);
		content = m.replaceAll("    ");

		p = Pattern.compile("<");
		m = p.matcher(content);
		content = m.replaceAll("&lt;");

		p = Pattern.compile(">");
		m = p.matcher(content);
		content = m.replaceAll("&gt;");

		String listing = "";
		listing += "<a class=\"exampleCollapsed\" href=\"#link_" + className + "\" onClick=\"toggleExample(this, '" + className + "');\">Show example</a><br />";
		listing += "<div id=\"" + className + "\" style='display:none'><listing version=\"3.0\">" + content + "</listing></div>";
		return listing;
	}

	public static void main(String[] args) {
		if (args.length < 2) {
			return;
		} else {
			new EmbedExamples(args[0], args[1]);
		}
	}
}
