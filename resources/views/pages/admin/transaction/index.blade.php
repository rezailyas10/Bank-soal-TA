@extends('layouts.admin')

@section('title')
  Transaction
@endsection

@section('content')
<div
class="section-content section-dashboard-home"
data-aos="fade-up"
>
<div class="container-fluid">
  <div class="dashboard-heading">
    <h2 class="dashboard-title">Transaction</h2>
    <p class="dashboard-subtitle">
      List Transactions
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
                                <th>Harga</th>
                                <th>Status </th>
                                <th>Dibuat </th>
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
        order: [[4, 'desc']], // Sort by the 5th column (created_at) in descending order
        ajax: {
            url: '{!! url()->current() !!}',
        },
        columns: [
            { 
                render: function (data, type, row, meta) {
                    return meta.row + 1; // Mengganti ID dengan nomor 1, 2, 3, ...
                }
            },
            {data: 'user.name', name: 'user.name'},
            {
                data: 'total_price', 
                name: 'total_price',
                render: function (data, type, row) {
                    return new Intl.NumberFormat('id-ID', { style: 'currency', currency: 'IDR' }).format(data);
                }
            },
            {data: 'transaction_status', name: 'transaction_status'},
            {
                data: 'created_at', 
                name: 'created_at',
                render: function (data, type, row) {
                    var date = new Date(data);
                    return date.toLocaleDateString('id-ID', {
                        year: 'numeric',
                        month: 'long',
                        day: 'numeric',
                        hour: '2-digit',
                        minute: '2-digit',
                        second: '2-digit'
                    });
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
    });
</script>

@endpush