using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Security.Policy;


namespace EMPS_PORTAL
{
    public partial class LeaveForm : System.Web.UI.Page
    {
        string s = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        SqlCommand cmd;
        SqlConnection con;
        SqlDataAdapter ad;
        DataSet ds;
        int i;
        string status = "Pending";
        DateTime sdate;
        DateTime edate;

        protected void Page_Load(object sender, EventArgs e)
        {
            getcon();
        }
        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (Button1.Text == "Submit Aplication")
            {
                getcon();
                sdate = Calendar1.SelectedDate.Date;
                edate = Calendar2.SelectedDate.Date;
                cmd = new SqlCommand(@"INSERT INTO leave_tbl 
            (Name, Empid, S_date, E_date, Reson, Status, Type) 
            VALUES (@Name, @Empid, @Sdate, @Edate, @Reson, @Status,@LeaveType)", con);

                cmd.Parameters.AddWithValue("@Name", txtun.Text);
                cmd.Parameters.AddWithValue("@Empid", txtEId.Text);

                cmd.Parameters.AddWithValue("@Sdate", sdate);
                cmd.Parameters.AddWithValue("@Edate", edate);
                cmd.Parameters.AddWithValue("@Reson", txtre.Text);
                cmd.Parameters.AddWithValue("@Status", status);
                cmd.Parameters.AddWithValue("@LeaveType", dle.SelectedValue);
                i = cmd.ExecuteNonQuery();
                if (i > 0)
                {
                    Response.Redirect("leave.aspx");
                }
            }
        }
    }
}