using CustomerRegistration.WebApi.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using System;
using System.Data;
using System.Data.SqlClient;

namespace CustomerRegistration.WebApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CustomerController : ControllerBase
    {
        private readonly IConfiguration _configuration; 
        public CustomerController(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        [Route("GetCustomer")]
        [HttpGet]
        public JsonResult GetCustomer()
        {
            DataTable table = new DataTable();
            try
            {
                string sqlDataConSource = _configuration.GetConnectionString("CustomerCon");
                SqlDataReader sqlData;
                using(SqlConnection con = new SqlConnection(sqlDataConSource))
                {
                    con.Open();
                    using(SqlCommand comm = new SqlCommand("SP_GetAllCustomers", con))
                    {
                        comm.CommandType = CommandType.StoredProcedure;
                        sqlData = comm.ExecuteReader();
                        table.Load(sqlData);
                        sqlData.Close();
                        con.Close();
                    }
                }
            }
            catch(Exception)
            {

            }

            return new JsonResult(table);
        }

        [Route("NewCustomer")]
        [HttpPost]
        public JsonResult NewCustomer(Customer entity)
        {
            DataTable table = new DataTable();
            string result = "";
            try
            {
                string sqlDataConSource = _configuration.GetConnectionString("CustomerCon");
                SqlDataReader sqlData;
                using (SqlConnection con = new SqlConnection(sqlDataConSource))
                {
                    con.Open();
                    using (SqlCommand comm = new SqlCommand("SP_InsertCustomer", con))
                    {
                        comm.CommandType = CommandType.StoredProcedure;
                        comm.Parameters.AddWithValue("@CusName", entity.CustomerName);
                        comm.Parameters.AddWithValue("@ContactNo", entity.ContactNo);
                        comm.Parameters.AddWithValue("@Address", entity.Address);
                        comm.Parameters.AddWithValue("@Email", entity.Email);
                        sqlData = comm.ExecuteReader();
                        table.Load(sqlData);
                        sqlData.Close();
                        con.Close();
                    }
                    if (table.Rows[0].Field<int>(0) == 1)
                    {
                        result = "Successfully Saved.";
                    }
                    else
                    {
                        result = "Failed.";
                    }
                }
            }
            catch(Exception)
            {
                result = "Failed.";
            }

            return new JsonResult(result);
        }
        [Route("UpdateCustomer")]
        [HttpPut]
        public JsonResult UpdateCustomer(Customer entity)
        {
            DataTable table = new DataTable();
            string result = "";
            try
            {
                string sqlDataConSource = _configuration.GetConnectionString("CustomerCon");
                SqlDataReader sqlData;
                using (SqlConnection con = new SqlConnection(sqlDataConSource))
                {
                    con.Open();
                    using (SqlCommand comm = new SqlCommand("SP_UpdateCustomer", con))
                    {
                        comm.CommandType = CommandType.StoredProcedure;
                        comm.Parameters.AddWithValue("@RID", entity.RID);
                        comm.Parameters.AddWithValue("@CusName", entity.CustomerName);
                        comm.Parameters.AddWithValue("@ContactNo", entity.ContactNo);
                        comm.Parameters.AddWithValue("@Address", entity.Address);
                        comm.Parameters.AddWithValue("@Email", entity.Email);
                        sqlData = comm.ExecuteReader();
                        table.Load(sqlData);
                        sqlData.Close();
                        con.Close();
                    }
                    if (table.Rows[0].Field<int>(0) == 1)
                    {
                        result = "Successfully Updated.";
                    }
                    else
                    {
                        result = "Failed.";
                    }
                }
            }
            catch(Exception)
            {
                result = "Failed.";
            }

            return new JsonResult(result);
        }
    }
}
