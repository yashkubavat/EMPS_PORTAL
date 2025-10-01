using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace EMPS_PORTAL
{
    public partial class employee : System.Web.UI.Page
    {
        string s = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        SqlCommand cmd;
        SqlConnection con;
        SqlDataAdapter ad;
        DataSet ds;
        int i;
        protected void Page_Load(object sender, EventArgs e)
        {
            getcon();
            if (Session["user"] == null)
            {
                Response.Redirect("login.aspx");

            }

            if (!IsPostBack)
            {
                Label1.Text = Session["name"].ToString();
                Label11.Text = Session["name"].ToString();
                Label12.Text = Session["dept"].ToString();
                filldatalist();
            }

        }
        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }
        void filldatalist()
        {
            getcon();
            ad = new SqlDataAdapter("select * from emp_tbl where Email='" + Session["user"] + "'", con);
            ds = new DataSet();
            ad.Fill(ds);
            DataList1.DataSource = ds;
            DataList1.DataBind();
            DataList2.DataSource = ds;
            DataList2.DataBind();
        }

        protected void DataList1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("edit.aspx?EID=" + Session["eid"]);
        }
    }
}