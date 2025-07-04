@extends('layouts.admin')

@section('title')
  Product
@endsection

@section('content')
<div
class="section-content section-dashboard-home"
data-aos="fade-up"
>
<div class="container-fluid">
  <div class="dashboard-heading">
    <h2 class="dashboard-title">Product</h2>
    <p class="dashboard-subtitle">
      List Products
    </p>
  </div>
  <div class="dashboard-content">
   <div class="row">
    <div class="col-md-12">
        <div class="card">
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-hover scroll-horizontal-vertical w-100" id="crudTable">
                        <thead>
                            <tr>
                                <th>No</th>
                                <th>Nama</th>
                                <th>Pemilik</th>
                                <th>Kategori </th>
                                <th>Harga </th>
                                <th>Aksi</th>
                            </tr>
                        </thead>
                        <tbody></tbody>

                    </table>
                </div>
            </div>
        </div>
    </div>

   </div>
</div>
</div>

@endsection

@push('addon-script')
    <script>
        var datatable = $('#crudTable').DataTable({
            processing: true,
            serverSide: true,
            ordering: true,
            ajax: {
                url: '{!! url()->current() !!}',
            },
            columns: [
                { 
                render: function (data, type, row, meta) {
                    return meta.row + 1; // Mengganti ID dengan nomor 1, 2, 3, ...
                }
            },
                {data: 'name', name: 'name'},
                {data: 'user.name', name: 'user.name'},
                {data: 'category.name', name: 'category.name'},
                {
                data: 'price', 
                name: 'price',
                render: function (data, type, row) {
                    return new Intl.NumberFormat('id-ID', { style: 'currency', currency: 'IDR' }).format(data);
                }
            },
                {
                    data: 'action', 
                    name: 'action',
                    orderable: false,
                    searchable: false,
                    width:'15%'
                }
            ]
        })
    </script>
@endpush