import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;

public class FileUtils {

	public static String readFile(String fileName) {
		String content = "";
		try {
			BufferedReader in = new BufferedReader(new FileReader(fileName));
			//read file into a string
			String input = "";
			while ((input = in.readLine()) != null) {
				content += input + '\n';
			}
			in.close();
		} catch (IOException e) {
			System.out.print("Error reading " + fileName + " " + e.toString());
		}
		return content;
	}
	
	public static void writeFile(String fileName, String content) {
		try {
			BufferedWriter out = new BufferedWriter(new FileWriter(fileName));
			 out.write(content);
			 out.close(); 
		} catch (IOException e) {
			System.out.print("Error writing " + fileName + " " + e.toString());
		}
	}

}
