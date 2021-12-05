<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Pdprof JMS page</title>
</head>
<body>
	<h2>JMS Send message (Q1, Q2 = normal queue, Q3 = mdb receive
		queue)</h2>
	<form action="q">
		<table>
			<tr>
				<td>Action :</td>
				<td><select name="action">
						<option value="send">send</option>
						<option value="receiveAll">receiveAll</option>
				</select></td>
			</tr>
			<tr>
				<td>Queue :</td>
				<td><select name="q">
						<option value="Q1">Q1 (default)</option>
						<option value="Q2">Q2 (2nd queue)</option>
						<option value="Q3">Q3 (mdb queue)</option>
				</select></td>
			</tr>
			<tr>
				<td>Message :</td>
				<td><input type="text" name="m" size="30"></input></td>
			</tr>
			<tr>
				<td></td>
				<td><button type="submit"><big>Submit</big></button></td>
			</tr>
		</table>
	</form>
</body>
</html>
