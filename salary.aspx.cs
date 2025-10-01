using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Reflection.Emit;

namespace EMPS_PORTAL
{
    public partial class salary : System.Web.UI.Page
    {
        SqlCommand cmd;
        DataSet ds;
        string s = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        SqlConnection con;
        SqlDataAdapter ad;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["user"] == null)
            {
                Response.Redirect("login.aspx");
            }
            Label1.Text = Session["name"].ToString();
            Label2.Text = Session["name"].ToString();
            Label3.Text = Session["dept"].ToString();
            getcon();
            labnet.Text = "0";
            labde.Text = "0";
            labnet.Text = "0";
            labbs.Text = "0";
            laboe.Text = "0";
            labha.Text = "0";
            fetchSalary();
            fillGrid();
        }
        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }
        void fetchSalary()
        {
            getcon();
            ad = new SqlDataAdapter("select * from salary_tbl where E_Id='" + Session["eid"] + "' ORDER BY Pay_Date DESC", con);
            ds = new DataSet();
            ad.Fill(ds);
            if (ds.Tables[0].Rows.Count > 0)
            {
                labbs.Text = ds.Tables[0].Rows[0]["Bassic_Salary"].ToString();
                labha.Text = ds.Tables[0].Rows[0]["HA"].ToString();
                laboe.Text = ds.Tables[0].Rows[0]["Other_Ern"].ToString();
                labde.Text = ds.Tables[0].Rows[0]["Leave_Deduction"].ToString();
                labnet.Text = ds.Tables[0].Rows[0]["Net_Pay"].ToString();
            }
        }
        void fillGrid()
        {
            getcon();
            ad = new SqlDataAdapter("select * from salary_tbl where E_Id='" + Session["eid"] + "' ORDER BY Pay_Date DESC", con);
            ds = new DataSet();
            ad.Fill(ds);

            GridView1.DataSource = ds;
            GridView1.DataBind();
        }
    }
}