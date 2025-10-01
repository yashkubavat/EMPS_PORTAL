using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.WebSockets;

namespace EMPS_PORTAL
{
    public partial class edit : System.Web.UI.Page
    {
        SqlCommand cmd;
        DataSet ds;
        string s = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        SqlConnection con;
        SqlDataAdapter ad;
        string fnm;
        int i;
        protected void Page_Load(object sender, EventArgs e)
        {
            getcon();

            if (!IsPostBack)
            {
                filldlct();
                select();
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
        void select()
        {
            ad = new SqlDataAdapter("select * from emp_tbl where Id='" + Request.QueryString["EID"] + "'", con);
            ds = new DataSet();
            ad.Fill(ds);

            txtun.Text = ds.Tables[0].Rows[0][1].ToString();
            txtem.Text = ds.Tables[0].Rows[0][2].ToString();
            txtmo.Text = ds.Tables[0].Rows[0][5].ToString();
            txtpass.Text = ds.Tables[0].Rows[0][3].ToString();
            txtct.Text = ds.Tables[0].Rows[0][6].ToString();
            rdbgd.SelectedValue = ds.Tables[0].Rows[0][7].ToString();
            drctdep.Text = ds.Tables[0].Rows[0][4].ToString();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (Button1.Text == "Save")
            {
                getcon();
                cmd = new SqlCommand("update emp_tbl set Name='" + txtun.Text + "',Email='" + txtem.Text + "',Password='" + txtpass.Text + "',Mobile='" + txtmo.Text + "',City='" + txtct.Text + "',Gender='" + rdbgd.SelectedValue + "',Department='" + ViewState["dept"] +"' where Id='" + Request.QueryString["EID"] + "'", con);
                i = cmd.ExecuteNonQuery();
                if (i > 0)
                {
                    Response.Redirect("employee.aspx");
                }
                else
                {
                    Response.Write("<script>alert('Update failed. Check your query or data.');</script>");
                }
            }
        }
        protected void drctdep_SelectedIndexChanged(object sender, EventArgs e)
        {
            getcon();
            ad = new SqlDataAdapter("select * from dept_tbl where D_Name='" + drctdep.SelectedItem.ToString() + "'", con);
            ds = new DataSet();
            ad.Fill(ds);
            ViewState["dept"] = ds.Tables[0].Rows[0][1].ToString();


        }
    }
}