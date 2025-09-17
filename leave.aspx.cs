using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace EMPS_PORTAL
{
    public partial class leave : System.Web.UI.Page
    {
        string s = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        SqlCommand cmd;
        SqlConnection con;
        SqlDataAdapter ad;
        DataSet ds;
        int i;
        protected void Page_Load(object sender, EventArgs e)
        {
            //if (Session["user"] == null)
            //{
            //    Response.Redirect("login.aspx");
            //}
            getcon();
            fillgrd();
            
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("LeaveForm.aspx");
        }

        protected void Button1_Click1(object sender, EventArgs e)
        {
            Response.Redirect("LeaveForm.aspx");
        }
        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }
        void fillgrd()
        {
            getcon();
            string p = "Approve";
            string r = "Reject";
            ad = new SqlDataAdapter("select Type, Status from leave_tbl", con);
            ds = new DataSet();
            ad.Fill(ds);
            GridView1.DataSource = ds;
            GridView1.DataBind();
        }
        
        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            fillgrd();
        }

        //protected void GridView2_SelectedIndexChanged(object sender, EventArgs e)
        //{

        //}
        
        //protected void GridView2_RowCommand(object sender, GridViewCommandEventArgs e)
        //{
           
        //}
    }
}