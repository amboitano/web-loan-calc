<%-- 
    Document   : CalcLoan
    Created on : Sep 25, 2018, 12:07:08 AM
    Author     : acmor
--%>

<%@page import="java.text.NumberFormat"%>
<%@page import="business.Loan"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Loan Schedule</title>
    </head>
    <body>
        <h1>Monthly Payment Schedule</h1>
        
        <%
            try {
          String prin = request.getParameter("prinbal");
          double p = Double.parseDouble(prin);
          double r = Double.parseDouble(request.getParameter("intrate"));
          int t = Integer.parseInt(request.getParameter("term"));
          
          Loan ln = new Loan(p,r,t);
          NumberFormat curr = NumberFormat.getCurrencyInstance();
          NumberFormat pct = NumberFormat.getPercentInstance();
          pct.setMinimumFractionDigits(3);
        %>
        
        <p>A payment of <%= curr.format(ln.getMonthlyPayment()) %> is required to 
            pay off a loan of <%= curr.format(ln.getPrincipal()) %> in 
            <%= ln.getTerm() %> months at a rate of: 
            <%= pct.format(ln.getRate()) %>
        </p>
        
        <table border="1">
            <tr>
                <th>Month</th>
                <th>Beg.Bal.</th>
                <th>Int.Chg.</th>
                <th>Prin.Amt.</th>
                <th>End.Bal.</th>
            </tr>
            <%
                for (int i=1; i<=ln.getTerm(); i++) {
             %>
             <tr>
                 <td align="right"><%= i %></td>
                 <td align="right"><%= curr.format(ln.getBegBal(i)) %></td>
                 <td align="right"><%= curr.format(ln.getIntCharged(i)) %></td>
                 <td align="right"></td>
                 <td align="right"><%= curr.format(ln.getEndBal(i)) %></td>
             </tr>
               <% } %>
        </table>
        <%
            } catch (Exception e) {
            %>
            <p>Process error: <%= e.getMessage() %></p>
            <% } %>
    </body>
</html>
