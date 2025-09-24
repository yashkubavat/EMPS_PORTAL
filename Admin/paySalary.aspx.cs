using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;

namespace EMPS_PORTAL.Admin
{
    public partial class paySalary : System.Web.UI.Page
    {
        SqlCommand cmd;
        DataSet ds;
        string s = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        SqlConnection con;
        SqlDataAdapter ad;
        string apr = "Approve";
        int i, leaveCount;
        decimal total, ot, ha, bs, de;
        DateTime payMonth, payDate;
        protected void Page_Load(object sender, EventArgs e)
        {
            getcon();
            if (!IsPostBack)
            {
                filldlct();
                fetchEmployee();
                fetchLeave();
            }

        }
        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }
        void filldlct()
        {
            getcon();
            ad = new SqlDataAdapter("select * from dept_tbl", con);
            ds = new DataSet();
            ad.Fill(ds);
            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                drctdep.Items.Add(ds.Tables[0].Rows[i][1].ToString());
            }
        }
        void fetchEmployee()
        {
            getcon();
            ad = new SqlDataAdapter("select * from emp_tbl", con);
            ds = new DataSet();
            ad.Fill(ds);
            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                dlemp.Items.Add(ds.Tables[0].Rows[i][1].ToString());
            }
        }
        void fetchLeave()
        {
            leaveCount = 0;
            int cut = 500;
            decimal leaveCuts;
            getcon();
            ad = new SqlDataAdapter("select * from leave_tbl where Empid='" + ViewState["eid"] + "' and Status='" + apr + "'", con);
            ds = new DataSet();
            ad.Fill(ds);

            leaveCount = ds.Tables[0].Rows.Count;
            ViewState["leavecount"] = leaveCount;
            txtLeaveDeduction.Text = leaveCount.ToString();
            leaveCuts = cut * leaveCount;
            de = leaveCuts;
            txtleave.Text = de.ToString();
        }

        void cal()
        {
            bs = decimal.Parse(txtbs.Text);
            ha = decimal.Parse(txtha.Text);
            ot = decimal.Parse(txtoe.Text);
            de = decimal.Parse(txtleave.Text);
            total = (bs + ha + ot) - de;
            txtnet.Text = total.ToString();

        }

        protected void dlemp_SelectedIndexChanged(object sender, EventArgs e)
        {
            getcon();
            ad = new SqlDataAdapter("select * from emp_tbl where Name='" + dlemp.SelectedItem.ToString() + "'", con);
            ds = new DataSet();
            ad.Fill(ds);
            ViewState["ename"] = ds.Tables[0].Rows[0][1].ToString();
            ViewState["eid"] = ds.Tables[0].Rows[0]["Id"].ToString();
            txteid.Text = ViewState["eid"].ToString();
            ViewState["department"] = ds.Tables[0].Rows[0]["Department"].ToString();
            drctdep.Text = ViewState["department"].ToString();
            fetchLeave();
        }

        void summery()
        {
            labbass.Text = bs.ToString();
            labhr.Text = ha.ToString();
            labother.Text = ot.ToString();
            labdedu.Text = de.ToString();
            labnet.Text = total.ToString();
        }


        protected void drctdep_SelectedIndexChanged(object sender, EventArgs e)
        {
            getcon();
            ad = new SqlDataAdapter("select * from dept_tbl where D_Name='" + drctdep.SelectedItem.ToString() + "'", con);
            ds = new DataSet();
            ad.Fill(ds);
            ViewState["dept"] = ds.Tables[0].Rows[0][1].ToString();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            getcon();
            cal();
            cmd = new SqlCommand("insert into salary_tbl (E_Name, E_Id, E_Department, Pay_Period, Pay_Date, Bassic_Salary, HA, Other_Ern, Leave_Deduction, Net_Pay, Pay_Method, Pay_Details) values ('" + dlemp.SelectedItem.ToString() + "','" + txteid.Text + "','" + drctdep.SelectedItem.ToString() + "','" + txtpaymonth.Text + "','" + txtpaydate.Text + "','" + txtbs.Text + "','" + txtha.Text + "','" + txtoe.Text + "','" + txtleave.Text + "','" + txtnet.Text + "','" + dlpay.SelectedItem.ToString() + "','" + txtbd.Text + "')", con);
            i = cmd.ExecuteNonQuery();
            if (i > 0)
            {
                Response.Redirect("salary.aspx");
            }
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            cal();
            summery();
        }
    }
}