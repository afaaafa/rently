class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.string :type, null: false
      t.string :email_address, null: false
      t.string :password_digest, null: false
      t.string :rg
      t.string :cpf
      t.string :name
      t.json   :address
      t.string :profession

      # Empresa (Agente subtype)
      t.string :company_name
      t.string :cnpj

      # Banco (Agente subtype)
      t.string :bank_code

      t.timestamps
    end
    add_index :users, :email_address, unique: true
    add_index :users, :type
  end
end
