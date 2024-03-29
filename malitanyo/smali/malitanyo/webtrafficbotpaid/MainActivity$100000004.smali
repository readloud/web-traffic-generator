.class Lmalitanyo/webtrafficbotpaid/MainActivity$100000004;
.super Ljava/lang/Object;
.source "MainActivity.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lmalitanyo/webtrafficbotpaid/MainActivity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x20
    name = "100000004"
.end annotation


# instance fields
.field private final this$0:Lmalitanyo/webtrafficbotpaid/MainActivity;


# direct methods
.method constructor <init>(Lmalitanyo/webtrafficbotpaid/MainActivity;)V
    .locals 5

    move-object v0, p0

    move-object v1, p1

    move-object v3, v0

    invoke-direct {v3}, Ljava/lang/Object;-><init>()V

    move-object v3, v0

    move-object v4, v1

    iput-object v4, v3, Lmalitanyo/webtrafficbotpaid/MainActivity$100000004;->this$0:Lmalitanyo/webtrafficbotpaid/MainActivity;

    return-void
.end method

.method static access$0(Lmalitanyo/webtrafficbotpaid/MainActivity$100000004;)Lmalitanyo/webtrafficbotpaid/MainActivity;
    .locals 4

    move-object v0, p0

    move-object v3, v0

    iget-object v3, v3, Lmalitanyo/webtrafficbotpaid/MainActivity$100000004;->this$0:Lmalitanyo/webtrafficbotpaid/MainActivity;

    move-object v0, v3

    return-object v0
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 19
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/view/View;",
            ")V"
        }
    .end annotation

    .annotation runtime Ljava/lang/Override;
    .end annotation

    .prologue
    .line 134
    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move-object v11, v0

    iget-object v11, v11, Lmalitanyo/webtrafficbotpaid/MainActivity$100000004;->this$0:Lmalitanyo/webtrafficbotpaid/MainActivity;

    iget-object v11, v11, Lmalitanyo/webtrafficbotpaid/MainActivity;->ed1:Landroid/widget/EditText;

    invoke-virtual {v11}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v11

    invoke-interface {v11}, Landroid/text/Editable;->toString()Ljava/lang/String;

    move-result-object v11

    const-string v12, "http"

    invoke-virtual {v11, v12}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v11

    if-nez v11, :cond_0

    move-object v11, v0

    iget-object v11, v11, Lmalitanyo/webtrafficbotpaid/MainActivity$100000004;->this$0:Lmalitanyo/webtrafficbotpaid/MainActivity;

    iget-object v11, v11, Lmalitanyo/webtrafficbotpaid/MainActivity;->in1:Landroid/widget/EditText;

    invoke-virtual {v11}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v11

    invoke-interface {v11}, Landroid/text/Editable;->toString()Ljava/lang/String;

    move-result-object v11

    const-string v12, "0"

    invoke-virtual {v11, v12}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v11

    if-eqz v11, :cond_1

    .line 136
    :cond_0
    move-object v11, v0

    iget-object v11, v11, Lmalitanyo/webtrafficbotpaid/MainActivity$100000004;->this$0:Lmalitanyo/webtrafficbotpaid/MainActivity;

    iget-object v11, v11, Lmalitanyo/webtrafficbotpaid/MainActivity;->ed1:Landroid/widget/EditText;

    invoke-virtual {v11}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v11

    invoke-interface {v11}, Landroid/text/Editable;->toString()Ljava/lang/String;

    move-result-object v11

    move-object v3, v11

    .line 137
    move-object v11, v0

    iget-object v11, v11, Lmalitanyo/webtrafficbotpaid/MainActivity$100000004;->this$0:Lmalitanyo/webtrafficbotpaid/MainActivity;

    iget-object v11, v11, Lmalitanyo/webtrafficbotpaid/MainActivity;->in1:Landroid/widget/EditText;

    invoke-virtual {v11}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v11

    invoke-interface {v11}, Landroid/text/Editable;->toString()Ljava/lang/String;

    move-result-object v11

    move-object v4, v11

    .line 138
    move-object v11, v0

    iget-object v11, v11, Lmalitanyo/webtrafficbotpaid/MainActivity$100000004;->this$0:Lmalitanyo/webtrafficbotpaid/MainActivity;

    iget-object v11, v11, Lmalitanyo/webtrafficbotpaid/MainActivity;->in2:Landroid/widget/EditText;

    invoke-virtual {v11}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v11

    invoke-interface {v11}, Landroid/text/Editable;->toString()Ljava/lang/String;

    move-result-object v11

    move-object v5, v11

    .line 139
    move-object v11, v0

    iget-object v11, v11, Lmalitanyo/webtrafficbotpaid/MainActivity$100000004;->this$0:Lmalitanyo/webtrafficbotpaid/MainActivity;

    iget-object v11, v11, Lmalitanyo/webtrafficbotpaid/MainActivity;->in1:Landroid/widget/EditText;

    invoke-virtual {v11}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v11

    invoke-interface {v11}, Landroid/text/Editable;->toString()Ljava/lang/String;

    move-result-object v11

    move-object v6, v11

    .line 140
    move-object v11, v0

    iget-object v11, v11, Lmalitanyo/webtrafficbotpaid/MainActivity$100000004;->this$0:Lmalitanyo/webtrafficbotpaid/MainActivity;

    iget-object v11, v11, Lmalitanyo/webtrafficbotpaid/MainActivity;->in2:Landroid/widget/EditText;

    invoke-virtual {v11}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v11

    invoke-interface {v11}, Landroid/text/Editable;->toString()Ljava/lang/String;

    move-result-object v11

    move-object v7, v11

    .line 141
    new-instance v11, Landroid/content/Intent;

    move-object/from16 v18, v11

    move-object/from16 v11, v18

    move-object/from16 v12, v18

    move-object v13, v0

    iget-object v13, v13, Lmalitanyo/webtrafficbotpaid/MainActivity$100000004;->this$0:Lmalitanyo/webtrafficbotpaid/MainActivity;

    iget-object v13, v13, Lmalitanyo/webtrafficbotpaid/MainActivity;->context:Landroid/content/Context;

    :try_start_0
    const-string v14, "malitanyo.webtrafficbotpaid.single"

    invoke-static {v14}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;
    :try_end_0
    .catch Ljava/lang/ClassNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v14

    invoke-direct {v12, v13, v14}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    move-object v8, v11

    .line 142
    move-object v11, v8

    const-string v12, "TIME"

    move-object v13, v4

    invoke-virtual {v11, v12, v13}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v11

    .line 143
    move-object v11, v8

    const-string v12, "URL"

    move-object v13, v3

    invoke-virtual {v11, v12, v13}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v11

    .line 144
    move-object v11, v8

    const-string v12, "LIMIT"

    move-object v13, v5

    invoke-virtual {v11, v12, v13}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v11

    .line 145
    move-object v11, v8

    const-string v12, "POP"

    move-object v13, v6

    invoke-virtual {v11, v12, v13}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v11

    .line 146
    move-object v11, v8

    const-string v12, "JAVA"

    move-object v13, v7

    invoke-virtual {v11, v12, v13}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v11

    .line 147
    move-object v11, v0

    iget-object v11, v11, Lmalitanyo/webtrafficbotpaid/MainActivity$100000004;->this$0:Lmalitanyo/webtrafficbotpaid/MainActivity;

    move-object v12, v8

    invoke-virtual {v11, v12}, Lmalitanyo/webtrafficbotpaid/MainActivity;->startActivity(Landroid/content/Intent;)V

    .line 156
    :goto_0
    return-void

    .line 141
    :catch_0
    move-exception v11

    move-object v9, v11

    new-instance v11, Ljava/lang/NoClassDefFoundError;

    move-object/from16 v18, v11

    move-object/from16 v11, v18

    move-object/from16 v12, v18

    move-object v13, v9

    invoke-virtual {v13}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object v13

    invoke-direct {v12, v13}, Ljava/lang/NoClassDefFoundError;-><init>(Ljava/lang/String;)V

    throw v11

    .line 150
    :cond_1
    new-instance v11, Landroid/app/AlertDialog$Builder;

    move-object/from16 v18, v11

    move-object/from16 v11, v18

    move-object/from16 v12, v18

    move-object v13, v0

    iget-object v13, v13, Lmalitanyo/webtrafficbotpaid/MainActivity$100000004;->this$0:Lmalitanyo/webtrafficbotpaid/MainActivity;

    invoke-direct {v12, v13}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    move-object v3, v11

    .line 151
    move-object v11, v0

    iget-object v11, v11, Lmalitanyo/webtrafficbotpaid/MainActivity$100000004;->this$0:Lmalitanyo/webtrafficbotpaid/MainActivity;

    iget-object v11, v11, Lmalitanyo/webtrafficbotpaid/MainActivity;->ed1:Landroid/widget/EditText;

    invoke-virtual {v11}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v11

    invoke-interface {v11}, Landroid/text/Editable;->toString()Ljava/lang/String;

    move-result-object v11

    move-object v4, v11

    .line 152
    move-object v11, v0

    iget-object v11, v11, Lmalitanyo/webtrafficbotpaid/MainActivity$100000004;->this$0:Lmalitanyo/webtrafficbotpaid/MainActivity;

    iget-object v11, v11, Lmalitanyo/webtrafficbotpaid/MainActivity;->in1:Landroid/widget/EditText;

    invoke-virtual {v11}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v11

    invoke-interface {v11}, Landroid/text/Editable;->toString()Ljava/lang/String;

    move-result-object v11

    move-object v5, v11

    .line 153
    move-object v11, v3

    const/high16 v12, 0x7f050000

    invoke-virtual {v11, v12}, Landroid/app/AlertDialog$Builder;->setMessage(I)Landroid/app/AlertDialog$Builder;

    move-result-object v11

    .line 154
    move-object v11, v3

    invoke-virtual {v11}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    move-result-object v11

    .line 155
    move-object v11, v0

    iget-object v11, v11, Lmalitanyo/webtrafficbotpaid/MainActivity$100000004;->this$0:Lmalitanyo/webtrafficbotpaid/MainActivity;

    iget-object v11, v11, Lmalitanyo/webtrafficbotpaid/MainActivity;->ed1:Landroid/widget/EditText;

    new-instance v12, Ljava/lang/StringBuffer;

    move-object/from16 v18, v12

    move-object/from16 v12, v18

    move-object/from16 v13, v18

    invoke-direct {v13}, Ljava/lang/StringBuffer;-><init>()V

    const-string v13, "Error Invaled url: "

    invoke-virtual {v12, v13}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v12

    move-object v13, v4

    invoke-virtual {v12, v13}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v12

    invoke-virtual {v12}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v11, v12}, Landroid/widget/EditText;->setError(Ljava/lang/CharSequence;)V

    .line 156
    move-object v11, v0

    iget-object v11, v11, Lmalitanyo/webtrafficbotpaid/MainActivity$100000004;->this$0:Lmalitanyo/webtrafficbotpaid/MainActivity;

    iget-object v11, v11, Lmalitanyo/webtrafficbotpaid/MainActivity;->in1:Landroid/widget/EditText;

    new-instance v12, Ljava/lang/StringBuffer;

    move-object/from16 v18, v12

    move-object/from16 v12, v18

    move-object/from16 v13, v18

    invoke-direct {v13}, Ljava/lang/StringBuffer;-><init>()V

    const-string v13, "Time Interval not be blank.\n\n5000 = 5seconds.\n11000 = 11seconds: "

    invoke-virtual {v12, v13}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v12

    move-object v13, v5

    invoke-virtual {v12, v13}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v12

    invoke-virtual {v12}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v11, v12}, Landroid/widget/EditText;->setError(Ljava/lang/CharSequence;)V

    goto/16 :goto_0
.end method
