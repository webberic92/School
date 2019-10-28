
import java.io.*;
import java.net.*;
public class EmailAgent {
	
	
	public static void main(String[] args) throws Exception {
		
		// Establish a TCP connection with the mail server.	
		Socket socket = new Socket("localhost", 25);
		
		//Create a BufferedReader to read a line at a time.
		InputStream is = socket.getInputStream();
		InputStreamReader isr = new InputStreamReader(is);
		BufferedReader br = new BufferedReader(isr);

		//Read greeting from the server.
		String response = br.readLine();
		System.out.println(response);
		if (!response.startsWith("220")) {
		throw new Exception("220 reply not received from server.");
		}
		
		//Get a reference to the socket's output stream.
		OutputStream os = socket.getOutputStream();
		
		//Send HELO command and get server response.
		String command = "HELO Eric\r\n";
		System.out.print(command);
		os.write(command.getBytes("US-ASCII"));
		response = br.readLine();
		System.out.println(response);
		if (!response.startsWith("250")) {
		throw new Exception("250 reply not received from server.");
		}
		
		//Send MAIL FROM command.
		command = "MAIL FROM: webberic92@yahoo.com\r\n";
		System.out.println(command);
		os.write(command.getBytes("US-ASCII"));
		response = br.readLine();
		System.out.println(response);
		if (!response.startsWith("250")) {
			throw new Exception("250 reply not received from server. MAIL");
			}
		
		//Send RCPT TO command.
		command = "RCPT TO: eric@webby.com\r\n";
		System.out.println(command);
		os.write(command.getBytes("US-ASCII"));
		response = br.readLine();
		System.out.println(response);
		if (!response.startsWith("250")) {
			throw new Exception("250 reply not received from server.");
			}
		
		//Send DATA command.
		command = "DATA\r\n";
		System.out.println(command);
		os.write(command.getBytes("US-ASCII"));
		response = br.readLine();
		System.out.println(response);
		if (!response.startsWith("354")) {
			throw new Exception("data 354  data not received from server.");
			}
		
		//Send message data.
		os.write("SUBJECT: JAVA SMTP \r\n".getBytes("US-ASCII"));
		os.write("Welcome to Webbys SMTP service! \r\n".getBytes("US-ASCII"));
		os.write("Ending Email now \r\n".getBytes("US-ASCII"));

				
		//End with line with a single period.
		os.write(".\r\n".getBytes("US-ASCII"));
		response = br.readLine();
		if (!response.startsWith("250")) {
			throw new Exception(" period 250 reply not received from server.");
			}

		
		//Send QUIT command.
		os.write("QUIT\r\n".getBytes("US-ASCII"));
		response = br.readLine();
		System.out.println(response);

		
	}
	
}









