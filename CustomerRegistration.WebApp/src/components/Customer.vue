<template>
    <div>
        <h1 style="text-align:center; background-color:powderblue">Customer Registration</h1>
        <hr />
        <div class="row m-1 p-2">
            <div class="col-md-6">
                <div class="row">
                    <div class="col-md-4 ">
                        <span class="input-group-text">Filter By Customer Name</span>
                    </div>
                    <div class="col-md-8">
                        <input class="form-control"
                               v-model="CustomerNameFilter"
                               v-on:keyup="FilterFn()"
                               placeholder="Filter">
                    </div>
                </div>
            </div>
            <div class="col-md-6 d-flex justify-content-end">
                <button type="button"
                        class="btn btn-primary m-2 fload-end"
                        data-bs-toggle="modal"
                        data-bs-target="#CustomerModal"
                        @click="addClick()">
                    Add Customer
                </button>
            </div>
        </div>
        <div class="border border-primary m-2 p-2 rounded">
            <table class="table table-striped" id="tblCustomer">
                <thead>
                    <tr>
                        <th>Customer Id</th>
                        <th>Customer Name</th>
                        <th>Contact Number</th>
                        <th>Address</th>
                        <th>Email</th>
                        <th>Edit</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="cus in customers" v-bind:key="cus.RID">
                        <td>{{cus.RID}}</td>
                        <td>{{cus.CustomerName}}</td>
                        <td>{{cus.ContactNo}}</td>
                        <td>{{cus.Address}}</td>
                        <td>{{cus.Email}}</td>
                        <td>
                            <button type="button"
                                    class="btn btn-light mr-1"
                                    data-bs-toggle="modal"
                                    data-bs-target="#CustomerModal"
                                    @click="editClick(cus)">
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16">
                                    <path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z" />
                                    <path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5v11z" />
                                </svg>
                            </button>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div class="modal fade" id="CustomerModal" tabindex="-1"
             aria-labelledby="CustomerModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="CustomerModalLabel">{{modalTitle}}</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"
                                aria-label="Close"></button>
                    </div>

                    <div class="modal-body">
                        <div class="input-group mb-3 row">
                            <div class="col-md-3 pl-1">
                                <span class="input-group-text">Customer Name</span>
                            </div>
                            <div class="col-md-9 pe-0">
                                <input type="text" class="form-control" v-model="CustomerName">
                            </div>
                        </div>

                        <div class="input-group mb-3 row">
                            <div class="col-md-3 pl-1">
                                <span class="input-group-text">Contact Number</span>
                            </div>
                            <div class="col-md-9 pe-0">
                                <input type="text" class="form-control" v-model="ContactNo" @keydown="onlyNumber()" maxlength="10">
                            </div>
                        </div>

                        <div class="input-group mb-3 row">
                            <div class="col-md-3 pl-1">
                                <span class="input-group-text">Address</span>
                            </div>
                            <div class="col-md-9 pe-0">
                                <input type="text" class="form-control" v-model="Address">
                            </div>
                        </div>
                        <div class="input-group mb-3 row">
                            <div class="col-md-3 pl-1">
                                <span class="input-group-text">Email</span>
                            </div>
                            <div class="col-md-9 pe-0">
                                <input type="email" class="form-control" v-model="Email">
                            </div>
                        </div>

                        <div class="mb-3 row">
                            <div class="col-md-3"></div>
                            <div class="col-md-9 d-flex justify-content-end">
                                <button type="button" @click="createClick()"
                                        v-if="CustomerId==0" class="btn btn-primary">
                                    Create
                                </button>
                            </div>
                        </div>
                        <div class="mb-3 row">
                            <div class="col-md-3"></div>
                            <div class="col-md-9 d-flex justify-content-end">
                                <button type="button" @click="updateClick()"
                                        v-if="CustomerId!=0" class="btn btn-primary">
                                    Update
                                </button>
                            </div>
                        </div>
                        <p v-if="errors.length">
                            <b>Please correct the following error(s):</b>
                            <ul>
                                <li v-for="(error, index) in errors" v-bind:key="index" style="color:firebrick">{{ error }}</li>
                            </ul>
                        </p>
                    </div>

                        </div>
                    </div>
        </div>
    </div>
</template>

<script>
    //import $ from 'jquery';
    //import bootstrap from 'bootstrap';
    import axios from 'axios';
    export default {
        data: function () {
            return {
                customers: [],
                modalTitle: "",
                CustomerId: 0,
                CustomerName: "",
                ContactNo: "",
                Address: "",
                Email: "",
                CustomerNameFilter: "",
                customersWithoutFilter: [],
                errors: []
            }
        },
        methods: {
            refreshData() {
                axios.get("https://localhost:44357/api/customer/GetCustomer")
                    .then((response) => {
                        this.customers = response.data;
                        this.customersWithoutFilter = response.data;
                    });
            },
            addClick() {
                this.modalTitle = "Add Customer";
                this.CustomerId = 0;
                this.CustomerName = "";
                this.ContactNo = "";
                this.Address = "";
                this.Email = "";
                this.errors = [];
            },
            editClick(cus) {
                this.modalTitle = "Edit Customer";
                this.CustomerId = cus.RID;
                this.CustomerName = cus.CustomerName;
                this.ContactNo = cus.ContactNo;
                this.Address = cus.Address;
                this.Email = cus.Email;
                this.errors = [];
            },
            createClick() {
                this.errors = [];
                this.validateCustomer();
                if (!this.errors.length) {
                    axios.post("https://localhost:44357/api/customer/NewCustomer", {
                        CustomerName: this.CustomerName,
                        ContactNo: this.ContactNo,
                        Address: this.Address,
                        Email: this.Email
                    })
                        .then((response) => {
                            this.refreshData();
                            alert(response.data);
                            this.modalTitle = "Add Customer";
                            this.CustomerId = 0;
                            this.CustomerName = "";
                            this.ContactNo = "";
                            this.Address = "";
                            this.Email = "";
                        });
                }
            },
            updateClick() {
                //var modalName = document.getElementById('CustomerModal');
                this.errors = [];
                this.validateCustomer();
                if (!this.errors.length) {
                    axios.put("https://localhost:44357/api/customer/UpdateCustomer", {
                        RID: this.CustomerId,
                        CustomerName: this.CustomerName,
                        ContactNo: this.ContactNo,
                        Address: this.Address,
                        Email: this.Email
                    })
                        .then((response) => {
                            this.refreshData();
                            alert(response.data);
                            //this.CustomerId = 0;
                            //this.CustomerName = "";
                            //this.ContactNo = "";
                            //this.Address = "";
                            //this.Email = "";

                            //modal.hide();
                            //$('#CustomerModal').hide();
                            //$(".fade").removeClass("modal-backdrop");
                            //$(".fade").removeClass("show");
                            //$('body').removeClass('modal-open');
                            //$('.modal-backdrop.in').hide();
                            //$('#CustomerModal').modal({ backdrop: 'static', keyboard: false });
                            //$('.modal').hide();
                            //$("#CustomerModal").modal('hide');
                            //var myModalEl = document.getElementById('CustomerModal');
                            //var modal = bootstrap.Modal.getInstance(myModalEl);
                            //modal.hide();
                            
                        });                  
                }
            },
            validateCustomer: function () {
                if (!this.CustomerName) {
                    this.errors.push('Cutomer name is required.');
                }
                if (!this.ContactNo) {
                    this.errors.push('Contact No is required.');
                }
                else if (!this.validPhone(this.ContactNo)) {
                    this.errors.push('Valid contact number is required. (Eg: 07xxxxxxxx)');
                }
                if (!this.Address) {
                    this.errors.push('Address is required.');
                }
                if (!this.Email) {
                    this.errors.push('Email is required.');
                }
                else if (!this.validEmail(this.Email)) {
                    this.errors.push('Valid email is required. (Eg: example@gmail.com)');
                }
            },
            validEmail: function (email) {
                var re = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
                return re.test(email);
            },
            validPhone: function (phone) {
                var re = /^(0)[0-9]{9,10}$/
                return re.test(phone);
            },
            onlyNumber() {
                //console.log($event.keyCode); //keyCodes value
                /^(0)[0-9]{9,10}$/
            },
            FilterFn() {
                var CustomerNameFilter = this.CustomerNameFilter;

                this.customers = this.customersWithoutFilter.filter(
                    function (el) {
                        return el.CustomerName.toString().toLowerCase().includes(
                            CustomerNameFilter.toString().trim().toLowerCase()
                        )
                    });
            },
        },
        mounted() {
            //API Call
            axios
                .get("https://localhost:44357/api/customer/GetCustomer")
                .then((res) => {
                    this.customers = res.data;
                })
            this.refreshData();
        },
    }
</script>

<style scoped>
</style>