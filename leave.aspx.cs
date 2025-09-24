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
using System.Reflection.Emit;

namespace EMPS_PORTAL
{
    public partial class leave : System.Web.UI.Page
    {
        string s = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        SqlCommand cmd;
        SqlConnection con;
        SqlDataAdapter ad;
        DataSet ds;
        int i,reLeave,geLeave;
        int totalLeave=18;
        string apr= "Approve";
        string rej= "Reject";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["user"] == null)
            {
                Response.Redirect("login.aspx");
            }
            getcon();
            fillgrd();
            ReLeave();
            GeLeave();
            Label1.Text = Session["name"].ToString();
            Label2.Text = Session["name"].ToString();
            Label3.Text = Session["dept"].ToString();
            txtleave.Text = totalLeave.ToString();
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
            ad = new SqlDataAdapter("select Type,Reson, Status from leave_tbl where Empid='" + Session["eid"] +"'", con);
            ds = new DataSet();
            ad.Fill(ds);
            GridView1.DataSource = ds;
            GridView1.DataBind();
        }
        void ReLeave()
        {
            reLeave = totalLeave;
            ad = new SqlDataAdapter("select * from leave_tbl where Empid='" + Session["eid"] +"'", con);
            ds = new DataSet();
            ad.Fill(ds);
            for(int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                reLeave = totalLeave - (i+1);
                string rincrement= ds.Tables[0].Rows[i]["Status"].ToString();
                if (rincrement == rej)
                {
                    reLeave++;
                }
            }
            txtreleave.Text = reLeave.ToString();
            Session["reLeave"] = reLeave;
        }
        void GeLeave()
        {
            ad = new SqlDataAdapter("select * from leave_tbl where Empid='" + Session["eid"] +"' and Status='"+apr+ "'", con);
            ds = new DataSet();
            ad.Fill(ds);
            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                geLeave = (i + 1);
            }
            txtgrleave.Text = geLeave.ToString();
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