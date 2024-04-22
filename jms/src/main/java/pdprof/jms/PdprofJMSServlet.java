package pdprof.jms;

import java.io.IOException;
import java.io.PrintWriter;

import javax.jms.JMSException;
import javax.jms.Queue;
import javax.jms.QueueConnection;
import javax.jms.QueueConnectionFactory;
import javax.jms.QueueReceiver;
import javax.jms.QueueSender;
import javax.jms.QueueSession;
import javax.jms.TextMessage;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class PdprofJMSServlet
 */
@WebServlet("/q")
public class PdprofJMSServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public PdprofJMSServlet() {
		super();
	}

	/**
	 * @throws IOException 
	 * @throws ServletException 
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		String q = request.getParameter("q");
		String m = request.getParameter("m");
		boolean isHelp = true;
		try {
			if (action.equalsIgnoreCase("send")) {
				send(request, response, q, m);
				isHelp = false;
			} else if (action.equalsIgnoreCase("receiveAll")) {
				receiveAll(request, response, q);
				isHelp = false;
			} 
		} catch(Exception e) {
			e.printStackTrace();
		}
		if (isHelp) {
			help(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

	private void send(HttpServletRequest request, HttpServletResponse response, String q, String m)
			throws JMSException, NamingException, IOException {

		PrintWriter out = response.getWriter();
		System.out.println("> PdprofJMSServlet.send");
		out.println("<pre>> PdprofJMSServlet.send");

		QueueConnectionFactory cf1 = (QueueConnectionFactory) new InitialContext().lookup("java:comp/env/QCF");

		Queue queue = (Queue) new InitialContext().lookup("java:comp/env/" + q);

		QueueConnection con = cf1.createQueueConnection();
		con.start();
		QueueSession sessionSender = con.createQueueSession(false, javax.jms.Session.AUTO_ACKNOWLEDGE);

		QueueSender send = sessionSender.createSender(queue);

		TextMessage msg = sessionSender.createTextMessage();
		msg.setText(m);

		send.send(msg);
		sessionSender.commit();
		System.out.println("= PdprofJMSServlet.send to queue:" + q);
		out.println("= PdprofJMSServlet.send to queue:" + q);
		
		if (con != null)
			con.close();
		System.out.println("< PdprofJMSServlet.send");
		out.println("< PdprofJMSServlet.send</pre>");
		out.println("<a href=\"index.jsp\">index.jsp</a>");
		out.flush();
	}

	private void receiveAll(HttpServletRequest request, HttpServletResponse response, String q)
			throws JMSException, NamingException, IOException {
		PrintWriter out = response.getWriter();
		System.out.println("> PdprofJMSServletrReceiveAll");
		out.println("<pre>> PdprofJMSServlet.receiveAll");
		QueueConnectionFactory cf1 = (QueueConnectionFactory) new InitialContext().lookup("java:comp/env/QCF");

		Queue queue = (Queue) new InitialContext().lookup("java:comp/env/" + q);

		QueueConnection con = cf1.createQueueConnection();
		con.start();

		QueueSession session = con.createQueueSession(false, javax.jms.Session.AUTO_ACKNOWLEDGE);
		QueueReceiver receive = session.createReceiver(queue);

		TextMessage msg = null;

		do {
			msg = (TextMessage) receive.receive(2000);
			if (msg != null)
				System.out.println("= PdprofJMSServlet.receiveAll msg : " + msg);
				out.println("= PdprofJMSServlet.receiveAll msg : " + msg);
		} while (msg != null);

		if (con != null)
			con.close();
		System.out.println("< PdprofJMSServlet.receiveAll");
		out.println("< PdprofJMSServlet.receiveAll</pre>");
		out.println("<a href=\"index.jsp\">index.jsp</a>");
		out.flush();
	}
	
	private void help(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher =  request.getRequestDispatcher("index.jsp");
        dispatcher.forward(request, response);
	}

}
