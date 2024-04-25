﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using YameStore.Models;
using YameDatabase;

namespace YameStore.DAOs
{
    public class CustomerDAO
    {
        private readonly DatabaseFactory databaseFactory;

        public CustomerDAO()
        {
            databaseFactory = DBFactoryManager.Instance.GetFactory();
        }

        public bool Insert(Customer customer)
        {
            try
            {
                using (var conn = databaseFactory.CreateConnection())
                {
                    conn.Open();

                    var cmdText = @"INSERT INTO CUSTOMER (YameID, Phone, Name, Point, Discount, Active) 
                                    VALUES (@YameID, @Phone, @Name, @Point, @Discount, @Active)";
                    var cmd = databaseFactory.CreateCommand(cmdText, conn);

                    databaseFactory.AddParameterWithValue(cmd, "@YameID", customer.YameID);
                    databaseFactory.AddParameterWithValue(cmd, "@Phone", customer.Phone);
                    databaseFactory.AddParameterWithValue(cmd, "@Name", customer.Name);
                    databaseFactory.AddParameterWithValue(cmd, "@Point", customer.Point);
                    databaseFactory.AddParameterWithValue(cmd, "@Discount", customer.Discount);
                    databaseFactory.AddParameterWithValue(cmd, "@Active", customer.Active);

                    int rowsAffected = cmd.ExecuteNonQuery();
                    return rowsAffected > 0;
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error occurred while inserting customer: " + ex.Message);
                return false;
            }
        }

        public List<Customer> GetAll()
        {
            List<Customer> list = new List<Customer>();
            try
            {
                using (var conn = databaseFactory.CreateConnection())
                {
                    conn.Open();

                    var cmdText = "SELECT * FROM CUSTOMER";
                    var cmd = databaseFactory.CreateCommand(cmdText, conn);

                    var adapter = databaseFactory.CreateDataAdapter(cmd);
                    var table = new DataTable();
                    adapter.Fill(table);

                    foreach (DataRow row in table.Rows)
                    {
                        list.Add(new Customer(row));
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error occurred while getting customer list: " + ex.Message);
            }
            return list;
        }

        public Customer? GetById(int id)
        {
            Customer? customer = null;
            try
            {
                using (var conn = databaseFactory.CreateConnection())
                {
                    conn.Open();

                    var cmdText = "SELECT * FROM CUSTOMER WHERE ID = @ID";
                    var cmd = databaseFactory.CreateCommand(cmdText, conn);
                    databaseFactory.AddParameterWithValue(cmd, "@ID", id);

                    var reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        customer = new Customer(reader);
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error occurred while getting customer by ID: " + ex.Message);
            }
            return customer;
        }

        public bool Update(Customer customer)
        {
            try
            {
                using (var conn = databaseFactory.CreateConnection())
                {
                    conn.Open();

                    var cmdText = @"UPDATE CUSTOMER 
                                    SET YameID = @YameID, Phone = @Phone, Name = @Name,
                                        Point = @Point, Discount = @Discount, Active = @Active
                                    WHERE ID = @ID";
                    var cmd = databaseFactory.CreateCommand(cmdText, conn);

                    databaseFactory.AddParameterWithValue(cmd, "@YameID", customer.YameID);
                    databaseFactory.AddParameterWithValue(cmd, "@Phone", customer.Phone);
                    databaseFactory.AddParameterWithValue(cmd, "@Name", customer.Name);
                    databaseFactory.AddParameterWithValue(cmd, "@Point", customer.Point);
                    databaseFactory.AddParameterWithValue(cmd, "@Discount", customer.Discount);
                    databaseFactory.AddParameterWithValue(cmd, "@Active", customer.Active);
                    databaseFactory.AddParameterWithValue(cmd, "@ID", customer.ID);

                    int rowsAffected = cmd.ExecuteNonQuery();
                    return rowsAffected > 0;
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error occurred while updating customer: " + ex.Message);
                return false;
            }
        }

        public bool Delete(int id)
        {
            try
            {
                using (var conn = databaseFactory.CreateConnection())
                {
                    conn.Open();

                    var cmdText = "DELETE FROM CUSTOMER WHERE ID = @ID";
                    var cmd = databaseFactory.CreateCommand(cmdText, conn);
                    databaseFactory.AddParameterWithValue(cmd, "@ID", id);

                    int rowsAffected = cmd.ExecuteNonQuery();
                    return rowsAffected > 0;
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error occurred while deleting customer: " + ex.Message);
                return false;
            }
        }
    }
}
