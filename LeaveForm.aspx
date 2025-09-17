<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LeaveForm.aspx.cs" Inherits="EMPS_PORTAL.LeaveForm" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Leave Application Form</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f2f6fc;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 600px;
            margin: 40px auto;
            background: #fff;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 6px 12px rgba(0,0,0,0.1);
        }

        h2 {
            text-align: center;
            color: #2c3e50;
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 6px;
            font-weight: bold;
            color: #333;
        }

        .input, select, textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 14px;
        }

        .textarea {
            resize: vertical;
            min-height: 80px;
        }

        .button {
            width: 100%;
            padding: 12px;
            background: #27ae60;
            border: none;
            color: white;
            font-size: 16px;
            border-radius: 8px;
            cursor: pointer;
            transition: background 0.3s;
        }

            .button:hover {
                background: #219150;
            }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div class="container">
                <h2>Leave Application Form</h2>
                <form>
                    <label for="name">Full Name</label>
                    <%--<input type="text" id="name" name="name" placeholder="Enter your full name" required>--%>
                    <asp:TextBox ID="txtun" CssClass="input" placeholder="Enter your full name" runat="server"></asp:TextBox>

                    <label for="employeeId">Employee ID</label>
                    <%--<input type="text" id="employeeId" name="employeeId" placeholder="Enter your ID" required>--%>
                    <asp:TextBox ID="txtEId" CssClass="input" placeholder="Enter your ID" runat="server"></asp:TextBox>

                    <label for="leaveType">Type of Leave</label>
                    <%--<select id="leaveType" name="leaveType" required>
    <option value="">-- Select Leave Type --</option>
    <option value="sick">Sick Leave</option>
    <option value="casual">Casual Leave</option>
    <option value="vacation">Vacation</option>
    <option value="other">Other</option>
</select>--%>
                    <asp:DropDownList ID="dle" CssClass="select" runat="server">
                        <asp:ListItem>---Select Leave Type---</asp:ListItem>
                        <asp:ListItem>Sick Leave</asp:ListItem>
                        <asp:ListItem>Casual Leave</asp:ListItem>
                        <asp:ListItem>Office Leave</asp:ListItem>
                    </asp:DropDownList>

                    <label for="fromDate">From Date</label>
                    <%--<input type="date" id="fromDate" name="fromDate" required>--%>
                    <asp:Calendar ID="Calendar1" runat="server" BackColor="White" BorderColor="#3366CC" BorderWidth="1px" CellPadding="1" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="#003399" Height="200px" Width="220px">
                        <DayHeaderStyle BackColor="#99CCCC" ForeColor="#336666" Height="1px" />
                        <NextPrevStyle Font-Size="8pt" ForeColor="#CCCCFF" />
                        <OtherMonthDayStyle ForeColor="#999999" />
                        <SelectedDayStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                        <SelectorStyle BackColor="#99CCCC" ForeColor="#336666" />
                        <TitleStyle BackColor="#003399" BorderColor="#3366CC" BorderWidth="1px" Font-Bold="True" Font-Size="10pt" ForeColor="#CCCCFF" Height="25px" />
                        <TodayDayStyle BackColor="#99CCCC" ForeColor="White" />
                        <WeekendDayStyle BackColor="#CCCCFF" />
                    </asp:Calendar>

                    <label for="toDate">To Date</label>
                    <%--<input type="date" id="toDate" name="toDate" required>--%>
                    <asp:Calendar ID="Calendar2" runat="server" BackColor="White" BorderColor="#3366CC" BorderWidth="1px" CellPadding="1" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="#003399" Height="200px" Width="220px">
                        <DayHeaderStyle BackColor="#99CCCC" ForeColor="#336666" Height="1px" />
                        <NextPrevStyle Font-Size="8pt" ForeColor="#CCCCFF" />
                        <OtherMonthDayStyle ForeColor="#999999" />
                        <SelectedDayStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                        <SelectorStyle BackColor="#99CCCC" ForeColor="#336666" />
                        <TitleStyle BackColor="#003399" BorderColor="#3366CC" BorderWidth="1px" Font-Bold="True" Font-Size="10pt" ForeColor="#CCCCFF" Height="25px" />
                        <TodayDayStyle BackColor="#99CCCC" ForeColor="White" />
                        <WeekendDayStyle BackColor="#CCCCFF" />
                    </asp:Calendar>

                    <label for="reason">Reason for Leave</label>
                    <%--<textarea id="reason" name="reason" placeholder="Enter reason here..." required></textarea>--%>
                    <asp:TextBox ID="txtre" CssClass="textarea" runat="server" TextMode="MultiLine"></asp:TextBox>

                    <%--<button type="submit">Submit Application</button>--%>
                    <asp:Button ID="Button1" CssClass="button" runat="server" Text="Submit Aplication" OnClick="Button1_Click" />
                </form>
            </div>
        </div>
    </form>
</body>
</html>
