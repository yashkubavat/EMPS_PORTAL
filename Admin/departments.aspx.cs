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
    public partial class departments : System.Web.UI.Page
    {
        string s = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        SqlCommand cmd;
        SqlConnection con;
        SqlDataAdapter ad;
        DataSet ds;
        int i;
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["admin"] == null)
            {
                Response.Redirect("index.aspx");
            }
            getcon();
            filldatalist();
        }
        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }
        void filldatalist()
        {
            ad = new SqlDataAdapter("select * from dept_tbl", con);
            ds = new DataSet();
            ad.Fill(ds);
            DataList1.DataSource = ds;
            DataList1.DataBind();
        }
        protected void Button1_Click(object sender, EventArgs e)
        {

            if (Button1.Text == "Add Department")
            {
                getcon();
                cmd = new SqlCommand("insert into dept_tbl (D_Name) values ('" + txtdpt.Text + "')", con);
                i = cmd.ExecuteNonQuery();
                if (i > 0)
                {
                    Response.Write("<script>alert('Department Add!!!')</script>");
                    filldatalist();
                }
                else
                {
                    Response.Write("<script>alert('Something wrong!!!')</script>");
                }
            }
        }

        protected void DataList1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void DataList1_ItemCommand(object source, DataListCommandEventArgs e)
        {
            if (e.CommandName == "remove")
            {
                getcon();
                ViewState["id"] = Convert.ToInt32(e.CommandArgument);
                cmd = new SqlCommand("delete from dept_tbl where Id='" + ViewState["id"] + "'", con);
                i = cmd.ExecuteNonQuery();
                if (i > 0)
                {
                    Response.Write("<script>alert('Department Removed!!!')</script>");
                    filldatalist();
                }
                else
                {
                    Response.Write("<script>alert('Something wrong!!!')</script>");

                }
            }
        }
    }
}