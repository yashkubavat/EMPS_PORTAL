<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="paySalary.aspx.cs" Inherits="EMPS_PORTAL.Admin.paySalary" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Employee Salary Payment Form</title>
    <style>
        :root {
            --bg: #f4f7fb;
            --card: #ffffff;
            --accent: #2563eb;
            --muted: #6b7280;
            --success: #10b981;
            --danger: #ef4444;
            --radius: 10px;
            font-family: Inter, system-ui, -apple-system, "Segoe UI", Roboto, "Helvetica Neue", Arial;
        }

        * {
            box-sizing: border-box
        }

        body {
            margin: 0;
            background: linear-gradient(180deg,var(--bg),#eef2ff 60%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 24px;
            color: #111827;
        }

        .container {
            width: 100%;
            max-width: 920px;
            background: var(--card);
            border-radius: var(--radius);
            box-shadow: 0 10px 30px rgba(16,24,40,0.08);
            padding: 22px;
            display: grid;
            grid-template-columns: 1fr 360px;
            gap: 20px;
            align-items: start;
        }

        header {
            grid-column: 1 / -1;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 12px;
            margin-bottom: 8px;
        }

            header h1 {
                font-size: 20px;
                margin: 0;
            }

            header p {
                margin: 0;
                color: var(--muted);
                font-size: 13px
            }

        form {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .group {
            background: #fbfdff;
            border: 1px solid #eef2ff;
            padding: 12px;
            border-radius: 8px;
        }

        .grid {
            display: grid;
            gap: 12px;
            grid-template-columns: repeat(2, 1fr);
        }

        label {
            display: block;
            font-size: 13px;
            margin-bottom: 6px;
            color: #0f172a;
            font-weight: 600;
        }

        input[type="text"],
        input[type="number"],
        input[type="date"],
        select,
        textarea {
            width: 100%;
            padding: 10px 12px;
            border-radius: 8px;
            border: 1px solid #e6eef8;
            background: #fff;
            font-size: 14px;
            outline: none;
        }

            input:focus, select:focus, textarea:focus {
                box-shadow: 0 0 0 4px rgba(37,99,235,0.08);
                border-color: var(--accent);
            }

        .full {
            grid-column: 1 / -1
        }

        .right {
            text-align: right
        }

        .money-row {
            display: flex;
            gap: 8px;
        }

            .money-row > div {
                flex: 1
            }

        .summary {
            padding: 14px;
            border-radius: 10px;
            background: linear-gradient(180deg,#fbfbff,#ffffff);
            border: 1px solid #eef2ff;
        }

            .summary h3 {
                margin: 0 0 8px 0;
                font-size: 16px
            }

            .summary .line {
                display: flex;
                justify-content: space-between;
                gap: 8px;
                padding: 6px 0;
                border-bottom: 1px dashed #eef2ff;
                font-size: 14px;
                color: var(--muted);
            }

                .summary .line strong {
                    color: #111827;
                    font-weight: 700
                }

        .actions {
            display: flex;
            gap: 10px;
            margin-top: 12px;
        }

        .button {
            padding: 10px 14px;
            border-radius: 8px;
            border: 0;
            cursor: pointer;
            font-weight: 600;
            font-size: 14px;
        }

        .btn-primary {
            background: var(--accent);
            color: #fff
        }

        .btn-secondary {
            background: #fff;
            border: 1px solid #e6eef8;
            color: #111827
        }

        .btn-danger {
            background: var(--danger);
            color: white
        }

        footer.note {
            grid-column: 1 / -1;
            font-size: 13px;
            color: var(--muted);
            margin-top: 6px;
        }

        @media (max-width:900px) {
            .container {
                grid-template-columns: 1fr;
                padding: 16px
            }

            .grid {
                grid-template-columns: 1fr
            }

            .container .summary {
                order: 2
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div class="container" role="application" aria-labelledby="form-title">
                <header>
                    <div>
                        <h1 id="form-title">Employee Salary Payment</h1>
                        <p>Fill salary details and click <strong>Pay</strong> to process payment.</p>
                    </div>
                    <!-- <div style="text-align:right">
        <small style="color:var(--muted)">Form ID: SAL-2025-001</small>
      </div> -->
                </header>

                <!-- LEFT: Form -->
                <form id="salaryForm" novalidate>
                    <div class="group">
                        <div class="grid">
                            <div>
                                <label for="empName">Employee Name</label>
                                <%--<input id="empName" name="empName" type="text" required placeholder="e.g. John Doe" />--%>
                                <%--<asp:TextBox ID="txtem" type="text" runat="server"></asp:TextBox>--%>
                                <asp:DropDownList ID="dlemp" runat="server" AutoPostBack="True" OnSelectedIndexChanged="dlemp_SelectedIndexChanged">
                                    <asp:ListItem>---Employee Name---</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div>
                                <label for="empId">Employee ID</label>
                                <%--<input id="empId" name="empId" type="text" required placeholder="e.g. EMP-0012" />--%>
                                <asp:TextBox ID="txteid" type="text" runat="server"></asp:TextBox>
                            </div>

                            <div>
                                <label for="department">Department</label>
                                <%--<select id="department" name="department" required>
              <option value="">Select department</option>
              <option>Finance</option>
              <option>HR</option>
              <option>Development</option>
              <option>Sales</option>
              <option>Support</option>
            </select>--%>
                                <asp:DropDownList ID="drctdep" runat="server" AutoPostBack="True">
                                    <asp:ListItem>---Select Department---</asp:ListItem>
                                </asp:DropDownList>
                            </div>

                            <div>
                                <label for="designation">Taken Leaves</label>
            <%--<input id="designation" name="designation" type="text" placeholder="e.g. Software Engineer" />--%>
                                <asp:TextBox ID="txtLeaveDeduction" type="text" runat="server"></asp:TextBox>
                            </div>

                            <div>
                                <label for="payPeriod">Pay Period (month)</label>
                                <%--<input id="payPeriod" name="payPeriod" type="month" required />--%>
                                <%--<asp:Calendar ID="Calendar1" type="month" runat="server"></asp:Calendar>--%>
                                <asp:TextBox ID="txtpaymonth" type="month" runat="server"></asp:TextBox>
                            </div>

                            <div>
                                <label for="payDate">Payment Date</label>
                                <%--<input id="payDate" name="payDate" type="date" value="" />--%>
                                <%--<asp:Calendar ID="Calendar2" type="date" runat="server"></asp:Calendar>--%>
                                <asp:TextBox ID="txtpaydate" type="date" runat="server"></asp:TextBox>
                            </div>
                        </div>
                    </div>

                    <div class="group">
                        <label>Salary Components</label>
                        <div class="money-row">
                            <div>
                                <label for="basic">Basic Salary</label>
                                <%--<input id="basic" name="basic" type="number" min="0" step="0.01" value="0" required />--%>
                                <asp:TextBox ID="txtbs" type="number" runat="server"></asp:TextBox>
                            </div>
                            <div>
                                <label for="hra">HRA / Allowances</label>
                                <%--<input id="hra" name="hra" type="number" type="number" min="0" step="0.01" value="0" />--%>
                                <asp:TextBox ID="txtha" runat="server"></asp:TextBox>
                            </div>
                        </div>

                        <div class="money-row" style="margin-top: 10px">
                            <div>
                                <label for="other">Other Earnings</label>
                                <%--<input id="other" name="other" type="number" min="0" step="0.01" value="0" />--%>
                                <asp:TextBox ID="txtoe" type="number" runat="server"></asp:TextBox>
                            </div>
                            <div>
                                <label for="deductions">Leave Deductions</label>
                                <%--<input id="deductions" name="deductions" type="number" min="0" step="0.01" value="0" />--%>
                                <asp:TextBox ID="txtleave" type="number" runat="server"></asp:TextBox>
                            </div>
                        </div>

                        <div style="margin-top: 10px; display: flex; gap: 10px; align-items: center;">
                            <div style="flex: 1">
                                <label for="netPay">Net Pay</label>
                                <%--<input id="netPay" name="netPay" type="text" readonly value="0.00" />--%>
                                <asp:TextBox ID="txtnet" runat="server"></asp:TextBox>
                            </div>
                            <div style="width: 180px">
                                <label for="payMethod">Payment Method</label>
                                <%--<select id="payMethod" name="payMethod" required>
                                    <option value="">Select</option>
                                    <option>Bank Transfer</option>
                                    <option>Cheque</option>
                                    <option>Cash</option>
                                    <option>UPI</option>
                                </select>--%>
                                <asp:DropDownList ID="dlpay" runat="server">
                                    <asp:ListItem>Select</asp:ListItem>
                                    <asp:ListItem>Bank Transfer</asp:ListItem>
                                    <asp:ListItem>Cheque</asp:ListItem>
                                    <asp:ListItem>UPI</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                    </div>

                    <div class="group">
                        <label for="bankDetails">Bank / Payment Details</label>
                        <%--<input id="bankDetails" name="bankDetails" type="text" placeholder="Bank name, A/C no. / UPI ID / Cheque no." />--%>
                        <asp:TextBox ID="txtbd" type="text" placeholder="Bank name, A/C no. / UPI ID / Cheque no." runat="server"></asp:TextBox>
                        <!-- <div style="margin-top:8px">
          <label for="remarks">Remarks (optional)</label>
          <textarea id="remarks" name="remarks" rows="3" placeholder="Optional notes..."></textarea>
        </div> -->
                    </div>

                    <div class="actions">
                        <!-- <button type="button" class="btn-secondary" onclick="resetForm()">Reset</button> -->
                        <asp:Button ID="Button2" class="button btn-primary" runat="server" Text="Calculate Salary" OnClick="Button2_Click" />
                        <%--<button type="submit" class="btn-primary">Pay Salary</button>--%>
                        <asp:Button ID="Button1" class="button btn-primary" runat="server" Text="Pay Salary" OnClick="Button1_Click" />
                        <!-- <button type="button" class="btn-danger" onclick="downloadSlip()">Download Slip</button> -->
                        <%--<asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>--%>
                    </div>
                </form>

                <!-- RIGHT: Summary / Preview -->
                <aside class="summary" aria-label="salary summary">
                    <h3>Salary Summary</h3>
                    <div class="line"><span>Basic</span><span id="sumBasic"><asp:Label ID="labbass" runat="server" Text="Label"></asp:Label></span></div>
                    <div class="line"><span>HRA / Allowances</span><span id="sumHra"><asp:Label ID="labhr" runat="server" Text="Label"></asp:Label></span></div>
                    <div class="line"><span>Other Earnings</span><span id="sumOther"><asp:Label ID="labother" runat="server" Text="Label"></asp:Label></span></div>
                    <div class="line"><span>Deductions</span><span id="sumDed"><asp:Label ID="labdedu" runat="server" Text="Label"></asp:Label></span></div>
                    <div class="line" style="border-bottom: 2px solid #eef2ff; margin-top: 8px;">
                        <strong>Net Pay</strong>
                        <strong id="sumNet">
                            <asp:Label ID="labnet" runat="server" Text="Label"></asp:Label></strong>
                    </div>

                    <!-- <div style="margin-top:12px; display:flex; gap:8px;">
        <button class="btn-secondary" style="flex:1" onclick="fillSample()">Fill sample</button>
        <button class="btn-primary" style="flex:1" onclick="calculateNet()">Recalc</button>
      </div>

      <p style="margin-top:12px;color:var(--muted);font-size:13px">
        Tip: Use <em>Fill sample</em> to quickly test. Clicking <em>Pay Salary</em> will run browser-side validation.
      </p>
    </aside>

    <footer class="note">Note: This is a front-end form only. Integrate with your backend to actually process payments and store payroll records securely.</footer>
  </div>

  <script>
    // Small utility functions for calculation + demo actions
    const $ = id => document.getElementById(id);

    function toFloat(v){
      const n = parseFloat(v);
      return isNaN(n) ? 0 : n;
    }

    function calculateNet(){
      const basic = toFloat($('basic').value);
      const hra = toFloat($('hra').value);
      const other = toFloat($('other').value);
      const deductions = toFloat($('deductions').value);

      const gross = basic + hra + other;
      const net = Math.max(0, gross - deductions);

      $('netPay').value = net.toFixed(2);
      $('sumBasic').textContent = basic.toFixed(2);
      $('sumHra').textContent = hra.toFixed(2);
      $('sumOther').textContent = other.toFixed(2);
      $('sumDed').textContent = deductions.toFixed(2);
      $('sumNet').textContent = net.toFixed(2);
      return net;
    }

    // Auto recalc when amounts change
    ['basic','hra','other','deductions'].forEach(id => {
      document.getElementById(id).addEventListener('input', calculateNet);
    });

    // Reset form
    function resetForm(){
      document.getElementById('salaryForm').reset();
      ['sumBasic','sumHra','sumOther','sumDed','sumNet'].forEach(id => document.getElementById(id).textContent = '0.00');
      $('netPay').value = '0.00';
    }

    // Fill sample data for demo
    function fillSample(){
      $('empName').value = 'Amit Patel';
      $('empId').value = 'EMP-0123';
      $('department').value = 'Development';
      $('designation').value = 'Full Stack Developer';
      $('payPeriod').value = '2025-09';
      $('payDate').value = new Date().toISOString().slice(0,10);
      $('basic').value = 50000;
      $('hra').value = 10000;
      $('other').value = 3000;
      $('deductions').value = 4500;
      $('payMethod').value = 'Bank Transfer';
      $('bankDetails').value = 'HDFC Bank - A/C 1234567890';
      calculateNet();
    }

    // Simple download slip as text file (demo)
    function downloadSlip(){
      calculateNet();
      const data = {
        name: $('empName').value || '',
        empId: $('empId').value || '',
        period: $('payPeriod').value || '',
        payDate: $('payDate').value || '',
        basic: $('basic').value || '0',
        hra: $('hra').value || '0',
        other: $('other').value || '0',
        deductions: $('deductions').value || '0',
        net: $('netPay').value || '0',
        method: $('payMethod').value || '',
        bank: $('bankDetails').value || ''
      };
      const content = [
        'Salary Payment Slip',
        '-------------------',
        `Employee: ${data.name} (${data.empId})`,
        `Pay Period: ${data.period}`,
        `Payment Date: ${data.payDate}`,
        '',
        `Basic: ${data.basic}`,
        `HRA / Allowances: ${data.hra}`,
        `Other Earnings: ${data.other}`,
        `Deductions: ${data.deductions}`,
        `Net Pay: ${data.net}`,
        '',
        `Payment Method: ${data.method}`,
        `Payment Details: ${data.bank}`,
        '',
        'This slip is generated locally in your browser (demo).'
      ].join('\\n');

      const blob = new Blob([content], {type: 'text/plain'});
      const url = URL.createObjectURL(blob);
      const a = document.createElement('a');
      a.href = url;
      a.download = (data.empId || 'salary') + '-slip.txt';
      document.body.appendChild(a);
      a.click();
      a.remove();
      URL.revokeObjectURL(url);
    }

    // Form submit handler (demo only)
    document.getElementById('salaryForm').addEventListener('submit', function(e){
      e.preventDefault();
      const form = e.target;
      if(!form.checkValidity()){
        // Let HTML5 show validation UI
        form.reportValidity();
        return;
      }
      calculateNet();
      alert('Salary processed (demo). Integrate with backend to actually pay and record payroll.');
    });

    // initialize sample values for convenience
    // fillSample(); -->
                </script>
            </div>
    </form>
</body>
</html>
