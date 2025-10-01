using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace EMPS_PORTAL.Admin
{
    public partial class dashboard : System.Web.UI.Page
    {
        SqlCommand cmd;
        DataSet ds;
        string s = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        SqlConnection con;
        SqlDataAdapter ad;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["admin"] == null)
            {
                Response.Redirect("index.aspx");
            }
            getcon();
            fetchEmployee();
            fetchDepartment();
            fetchLeave();
        }
        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }
        void fetchEmployee()
        {
            getcon();
            ad = new SqlDataAdapter("select * from emp_tbl",con);
            ds=new DataSet();
            ad.Fill(ds);
            labem.Text= ds.Tables[0].Rows.Count.ToString();
        }
        void fetchDepartment()
        {
            getcon();
            ad = new SqlDataAdapter("select * from dept_tbl", con);
            ds = new DataSet();
            ad.Fill(ds);
            labdept.Text = ds.Tables[0].Rows.Count.ToString();
        }
        void fetchLeave()
        {
            getcon();
            string p = "Pending";
            ad = new SqlDataAdapter("select * from leave_tbl where Status='"+p+"'", con);
            ds = new DataSet();
            ad.Fill(ds);
            lableave.Text = ds.Tables[0].Rows.Count.ToString();
        }
    }
}