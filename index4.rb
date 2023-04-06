ActiveAdmin.register_page "Employee Details" do
  menu false

  action_item :print_details do
    link_to "Print Report", 'javascript:;', onclick: "printDiv('employee-details-report')", method: :get
  end

  action_item :print_card do
    link_to "Print Card", 'javascript:;', onclick: "printDiv('employee-id-card')", method: :get
  end

  controller do

    def index
      if params[:empid].present?
        id = params[:empid]
      else
        id = params[:employee] && params[:employee][:emp_id]
      end

      @employee = Employee.unscoped.find_by(emp_id: id)
    end
  end

  content only: 'index' do
    employee = @arbre_context.assigns[:employee]


    active_admin_form_for :employee, method: 'get' do |f|
      f.inputs "Filters" do
        input :emp_id, label: "Emp. No.", input_html: { value: (params[:employee] && params[:employee][:emp_id]) || params[:empid], style:"width:120px;" }, wrapper_html: { style:"width:280px;float:left;text-align:right;" }
        action :submit, label: "Show Details", wrapper_html: { style:"width:120px;float:left;" }
      end
    end

    panel "Card", style: "display:none" do
      div id:"employee-id-card" do
        para "<style type='text/css' media='print'>
                @media print {
                  @page { size:210mm 297mm; margin:7mm; }
                  table tr { line-height: 5mm; }
                  table td, table th { border: none; padding:0 1mm; }
                  #wrapper, #wrapper2 {
                    position: absolute;
                    left: 0;
                    right: 0;
                    top: 0;
                    bottom: 0;
                    border: 1px solid;
                    border-radius: 4mm;
                    width: 65mm;
                    height: 85mm;
                  }
                  #wrapper2 { left: 70mm; }
                  #wrapper2 ol li { margin: 2mm; }
                  .bg-00FF00 {
                    background: #00FF00;
                    -webkit-print-color-adjust: exact;
                  }
                  .bg-FF0000 {
                    background: #FF0000;
                    -webkit-print-color-adjust: exact;
                  }
                  .bg-0000FF {
                    background: #0000FF;
                    -webkit-print-color-adjust: exact;
                  }
                  .bg-8A9593 {
                    background: #8A9593;
                    -webkit-print-color-adjust: exact;
                  }
                  .bg-FFFF00 {
                    background: #FFFF00;
                    -webkit-print-color-adjust: exact;
                  }
                  .bg-8000FF {
                    background: #8000FF;
                    -webkit-print-color-adjust: exact;
                  }
                  .bg-3E3A37 {
                    background: #3E3A37;
                    -webkit-print-color-adjust: exact;
                  }
                  .bg-FF00FF {
                    background: #FF00FF;
                    -webkit-print-color-adjust: exact;
                  }
                }
              </style>".html_safe

        if employee.blank?
          para "<span style='font-style:italic;color:#777;'>Employee not found.</span>".html_safe
        else
          div id:"wrapper", style:"text-align:center;" do
            div style:"font-weight:bold;font-size:15px; margin-top:4mm;" do
              "Carlton Garments (Pvt) Ltd."
            end

            div style:"font-size:10px; font-weight:bold" do
              "Bridal Factory"
            end

            div style:"margin-top:3mm; font-size:10px;" do
              table do
                tr do
                  th style:"text-align:right; width:80px;" do
                    "EPF No:"
                  end
                  td employee.epf_no
                end
                tr do
                  th style:"text-align:right; width:80px;" do
                    "Name:"
                  end
                  td employee.emp_name
                end
                tr do
                  th style:"text-align:right; width:80px;" do
                    "Designation:"
                  end
                  td employee.designation && employee.designation.name
                end
                tr do
                  th style:"text-align:right; width:80px;" do
                    "Department:"
                  end
                  td employee.department && employee.department.name
                end
                tr do
                  th style:"text-align:right; width:80px;" do
                    "NIC No:"
                  end
                  td employee.nic_or_passport
                end
                tr do
                  th style:"text-align:right; width:70px;" do
                    "Join Date:"
                  end
                  td employee.date_of_joined && employee.date_of_joined.strftime('%Y-%m-%d')
                end
              end
            end

            div style:"margin:3mm auto; width:49mm; height:30mm;" do
              div style:"width:23mm; height:30mm; border:1px solid; float:left;" do
              end
              div style:"width:23mm; height:30mm; border: 1px solid; float:right;", class: "bg-#{(employee.department && employee.department.color_hash.upcase || '#FFFFFF').sub('#','')}" do
              end
            end
          end
        end

        div id:"wrapper2", style:"text-align:left;" do
          ol style: "margin: 4mm 2mm; font-weight:bold" do
            li "කාර්යාල වේලාවේදී ඔබගේ හැඳුනුම්පත පැළඳ සිටිය යුතුය."
            li "හැඳුනුම්පත අන්සතු කළ නොහැක."
            li "ඔබගේ හැඳුනුම්පත නැති වූ විගස කාර්යාලයට දැනුම් දිය යුතුය."
            li "වැටුප ලබා ගැනීමේදී ඔබගේ හැඳුනුම්පත ඉදිරිපත් කළ යුතුය.<br />එය ඔබ මෙම ආයතනයේ සේවකයකු බව හඳුනාගැනීමට උපකාරී වේ.".html_safe
            li "හැඳුනුම්පතෙහි සඳහන් අංශය ඔබ වැඩ කළ යුතු අංශය වේ."
            li "කාර්යාල වේලාවේදී ඔබ එම කලාපයේ රැඳී සිටිය යුතුය."
          end
        end
      end
    end
  end
end
