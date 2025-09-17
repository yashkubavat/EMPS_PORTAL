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
            //    Response.Redirect("index.aspx");
            //}
            
                fillgrd();
            
            
        }
        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }
        void fillgrd()
        {
             getcon();
            ad=new SqlDataAdapter("select * from leave_tbl", con);
            ds = new DataSet();
            ad.Fill(ds);
            GridView1.DataSource = ds;
            GridView1.DataBind();
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            
        }
        void update()
        {
            getcon();
            cmd = new SqlCommand("update leave_tbl set Status='" + ViewState["status"] +"' where Id='" + ViewState["id"] +"'", con);
            i=cmd.ExecuteNonQuery();
            if (i > 0)
            {
                Response.Write("<script>alert('Status updated!!!')</script>");
                fillgrd();
            }
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if(e.CommandName == "apr")
            {
                int id=Convert.ToInt32(e.CommandArgument);
                ViewState["id"] = id;
                ViewState["status"] = "Approve";
                update();
            }
            else
            {
                int id = Convert.ToInt32(e.CommandArgument);
                ViewState["id"] = id;
                ViewState["status"] = "Reject";
                update();
            }
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {

        }

        protected void apr(object sender, CommandEventArgs e)
        {

        }
    }
}